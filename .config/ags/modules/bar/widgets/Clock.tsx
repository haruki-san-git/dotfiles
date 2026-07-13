import { Gtk } from "ags/gtk4"
import { createPoll } from "ags/time"

export const Clock = (props: { $type: "start" | "center" | "end" }) => {
  const time = createPoll("", 1000, "date +%H:%M")
  const fullTime = createPoll("", 1000, "date +%H:%M:%S")

  return (
    <box
      $type={props.$type}
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
      class="clock-container"
    >
      <menubutton
        hexpand={true}
        halign={Gtk.Align.CENTER}
        tooltipText={fullTime}
      >
        <label label={time} />
        <popover>
          <Gtk.Calendar />
        </popover>
      </menubutton>
    </box>
  )
}