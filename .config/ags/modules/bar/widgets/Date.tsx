import { Gtk } from "ags/gtk4"
import { createPoll } from "ags/time"

export const Date = (props: { $type: "start" | "center" | "end" }) => {
  const date = createPoll("", 1000, "date +%d/%m/%Y")
  const fullDate = createPoll("", 1000, "date +%A,\\ %d\\ %B\\ %Y")

  return (
    <box
      $type={props.$type}
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
      class="date-container"
      tooltipText={fullDate}
    >
      <label label={date} />
    </box>
  )
}