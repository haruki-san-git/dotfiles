import { Gtk } from "ags/gtk4"
import { createBinding, createComputed, With } from "ags"
import AstalBattery from "gi://AstalBattery"
import AstalBluetooth from "gi://AstalBluetooth"
import AstalPowerProfiles from "gi://AstalPowerProfiles"

const battery = AstalBattery.get_default()
const bluetooth = AstalBluetooth.get_default()
const powerProfiles = AstalPowerProfiles.get_default()

const formatTime = (seconds: number) => {
  if (!seconds || !Number.isFinite(seconds) || seconds <= 0) return null
  const h = Math.floor(seconds / 3600)
  const m = Math.floor((seconds % 3600) / 60)
  if (h > 0) return `${h}h ${m}m`
  return `${m}m`
}

const profiles = [
  { id: "power-saver", label: "Risparmio energetico", icon: "power-profile-power-saver-symbolic" },
  { id: "balanced", label: "Bilanciato", icon: "power-profile-balanced-symbolic" },
  { id: "performance", label: "Prestazioni", icon: "power-profile-performance-symbolic" },
]

const profileDisplayNames: Record<string, string> = {
  "power-saver": "Power saver",
  "balanced": "Balanced",
  "performance": "Performance",
}

export const Battery = (props: { $type: "start" | "center" | "end" }) => {
  const percentage = createBinding(battery, "percentage")
  const iconName = createBinding(battery, "iconName")
  const charging = createBinding(battery, "charging")
  const timeToEmpty = createBinding(battery, "timeToEmpty")
  const timeToFull = createBinding(battery, "timeToFull")
  const devices = createBinding(bluetooth, "devices")
  const activeProfile = createBinding(powerProfiles, "activeProfile")

  const percentLabel = percentage((p) => `${Math.round(p * 100)}%`)

  const timeLabel = createComputed(
    [charging, timeToEmpty, timeToFull],
    (isCharging, empty, full) => {
      const t = formatTime(isCharging ? full : empty)
      if (!t) return ""
      return isCharging ? `Tempo alla carica completa: ${t}` : `Tempo rimanente: ${t}`
    }
  )

  // Monitora costantemente la lista e lo stato di connessione reale dei dispositivi
  const connectedDevice = createComputed([devices], (list) => {
    return list.find((d: AstalBluetooth.Device) => d.connected) ?? null
  })

  const profileLabel = activeProfile((p) => profileDisplayNames[p] ?? p)
  const profileValue = activeProfile((p) => {
    const idx = profiles.findIndex((x) => x.id === p)
    return idx === -1 ? 1 : idx
  })

  let popoverRef: Gtk.Popover

  return (
    <box
      $type={props.$type}
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
      class="clock-container"
    >
      <menubutton halign={Gtk.Align.CENTER}>
        <box spacing={4}>
          <image iconName={iconName} />
          <label label={percentLabel} />
        </box>
        <popover
          $={(self: Gtk.Popover) => {
            popoverRef = self
            self.set_offset(-113, 0)
          }}
        >
          <box orientation={Gtk.Orientation.VERTICAL} spacing={10} class="battery-popup">

            {/* Header */}
            <box class="popup-header" spacing={8}>
              <image iconName="battery-symbolic" pixelSize={18} />
              <label label="Batteria" class="popup-header-title" hexpand={true} halign={Gtk.Align.START} />
              <button class="close-btn" onClicked={() => popoverRef?.popdown()}>
                <label label="✕" />
              </button>
            </box>

            {/* Card: stato batteria */}
            <box orientation={Gtk.Orientation.VERTICAL} spacing={15} class="status-card">

              <box orientation={Gtk.Orientation.VERTICAL} spacing={6}>
                <box spacing={6}>
                  <image iconName={iconName} pixelSize={16} />
                  <label label="Batteria" class="row-title" />
                  <label label={timeLabel} class="row-subtext" hexpand={true} halign={Gtk.Align.END} />
                </box>
                <box spacing={8} valign={Gtk.Align.CENTER}>
                  <Gtk.LevelBar
                    cssClasses={["battery-bar"]}
                    value={percentage}
                    minValue={0}
                    maxValue={1}
                    hexpand={true}
                  />
                  <label label={percentLabel} class="row-percent" />
                </box>
              </box>

              {/* Sezione dinamica Bluetooth con binding reattivi interni */}
              <With value={connectedDevice}>
                {(device: AstalBluetooth.Device | null) => {
                  if (!device) return <box visible={false} />

                  // Crea binding espliciti legati all'istanza del dispositivo rilevato
                  const isConnected = createBinding(device, "connected")
                  const deviceBattery = createBinding(device, "batteryPercentage")
                  const deviceName = createBinding(device, "name")

                  return (
                    <box 
                      orientation={Gtk.Orientation.VERTICAL} 
                      spacing={6}
                      visible={isConnected} // Nasconde istantaneamente il widget se si disconnette
                    >
                      <box spacing={6}>
                        <image iconName="audio-headphones-symbolic" pixelSize={16} />
                        <label label={deviceName} class="row-title" />
                      </box>
                      <box spacing={8} valign={Gtk.Align.CENTER}>
                        <Gtk.LevelBar
                          cssClasses={["battery-bar"]}
                          value={deviceBattery}
                          minValue={0}
                          maxValue={1}
                          hexpand={true}
                        />
                        <label
                          label={deviceBattery((p) =>
                            p > 0 ? `${Math.round(p * 100)}%` : "—"
                          )}
                          class="row-percent"
                        />
                      </box>
                    </box>
                  )
                }}
              </With>

            </box>

            {/* Card: profilo energetico */}
            <box orientation={Gtk.Orientation.VERTICAL} spacing={4} class="status-card">
              <box spacing={6}>
                <label label="Profilo energetico" class="row-title-lg" hexpand={true} halign={Gtk.Align.START} />
                <label label={profileLabel} class="row-subtext-lg" />
              </box>

              <Gtk.Scale
                cssClasses={["profile-slider"]}
                drawValue={false}
                digits={0}
                $={(self: Gtk.Scale) => {
                  const adjustment = new Gtk.Adjustment({
                    lower: 0,
                    upper: 2,
                    stepIncrement: 1,
                    pageIncrement: 1,
                    value: profileValue.get(),
                  })
                  self.set_adjustment(adjustment)

                  self.add_mark(0, Gtk.PositionType.BOTTOM, null)
                  self.add_mark(1, Gtk.PositionType.BOTTOM, null)
                  self.add_mark(2, Gtk.PositionType.BOTTOM, null)

                  self.connect("change-value", (_widget, _scroll, value: number) => {
                    const snapped = Math.round(value)
                    const clamped = Math.max(0, Math.min(2, snapped))
                    if (adjustment.get_value() !== clamped) {
                      adjustment.set_value(clamped)
                    }
                    return true 
                  })

                  self.connect("value-changed", () => {
                    const idx = Math.round(self.get_value())
                    const target = profiles[idx]
                    if (target && powerProfiles.activeProfile !== target.id) {
                      powerProfiles.activeProfile = target.id
                    }
                  })

                  profileValue.subscribe(() => {
                    const newVal = profileValue.get()
                    if (Math.round(adjustment.get_value()) !== newVal) {
                      adjustment.set_value(newVal)
                    }
                  })
                }}
              />

              <box spacing={0} homogeneous={true}>
                {profiles.map((p) => {
                  const cssClasses = createComputed([activeProfile], (current) => {
                    return current === p.id ? ["profile-icon", "active"] : ["profile-icon"]
                  })

                  return (
                    <image 
                      iconName={p.icon} 
                      pixelSize={14} 
                      cssClasses={cssClasses} 
                      halign={Gtk.Align.CENTER} 
                    />
                  )
                })}
              </box>
            </box>

          </box>
        </popover>
      </menubutton>
    </box>
  )
}