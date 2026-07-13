import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { Workspaces } from "./widgets/Workspaces"
import { Clock } from "./widgets/Clock"
import { Date } from "./widgets/Date"
import { Battery } from "./widgets/Battery"

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
  
  return (
    <window
    visible
    name="bar"
    class="Bar"
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}
    application={app}
    >
      <centerbox cssName="centerbox">
        <Workspaces $type="start" />
        <Clock $type="center" />
        <box $type="end" spacing={3}>
          <Date $type="end" />
          <Battery $type="end" />
        </box>
      </centerbox>
    </window>
  )
}