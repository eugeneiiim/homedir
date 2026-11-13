// cmd-n: a new space whose first tab is split left/right.
import { View, div } from "gpui-kit";
import { run, props, closeOverlay } from "herdr";

export default class SplitSpace extends View {
  init() {
    closeOverlay(props().overlay);
    run("space.new");
    run("pane.split", { direction: "right" });
  }

  render() {
    return div();
  }
}
