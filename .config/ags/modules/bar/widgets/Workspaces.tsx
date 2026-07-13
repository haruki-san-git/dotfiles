import { Gtk } from "ags/gtk4"
import AstalHyprland from "gi://AstalHyprland"

const hyprland = AstalHyprland.Hyprland.get_default()!

export const Workspaces = (props: { $type: "start" | "center" | "end" }) => {
  const createButton = (id: number): Gtk.Button => {
    const btn = (<button />) as Gtk.Button
    btn.add_css_class("ws-button")
    btn.set_halign(Gtk.Align.CENTER)
    btn.set_valign(Gtk.Align.CENTER)

    const dot = (<box />) as Gtk.Widget
    dot.add_css_class("ws-dot")
    dot.set_halign(Gtk.Align.CENTER)
    dot.set_valign(Gtk.Align.CENTER)
    dot.set_hexpand(false)
    dot.set_vexpand(false)

    btn.set_child(dot)
    btn.connect("clicked", () => hyprland.dispatch("workspace", String(id)))

    const update = () => {
      const ws = hyprland.workspaces.find((w) => w.id === id)
      btn.visible = !!ws
      const isActive = hyprland.focusedWorkspace?.id === id
      if (isActive) {
        btn.add_css_class("active")
        btn.remove_css_class("inactive")
      } else {
        btn.add_css_class("inactive")
        btn.remove_css_class("active")
      }
    }

    hyprland.connect("notify::workspaces", update)
    hyprland.connect("notify::focused-workspace", update)
    update()

    return btn
  }

  const buttons = Array.from({ length: 10 }, (_, i) => i + 1).map(createButton)

  // Creazione della box principale
  const container = (<box
    spacing={3}
    halign={Gtk.Align.CENTER}
    valign={Gtk.Align.CENTER}
    children={buttons as Gtk.Widget[]}
  />) as Gtk.Box
  // Aggiungiamo la classe per lo sfondo della capsula
  container.add_css_class("ws-container")

  return container
}