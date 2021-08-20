import Desktop from "./lib/Desktop.jsx";
import Error from "./lib/Error.jsx";
import parse from "./lib/parse.jsx";
import styles from "./lib/styles.jsx";

const style = {
  position: "fixed",
  overflow: "hidden",
  left: "0px",
  bottom: "0px",
  fontFamily: styles.fontFamily,
  lineHeight: styles.lineHeight,
  fontSize: styles.fontSize,
  color: styles.colors.dim,
  fontWeight: styles.fontWeight
};

export const refreshFrequency = false;
export const command = "./nibar/scripts/spaces.sh";

export const render = ({ output }, ...args) => {
  const data = parse(output);
  if (typeof data === "undefined") {
    return null
    // return (
    //   <div style={style}>
    //     <Error msg="Error: unknown script output" side="left" />
    //   </div>
    // );
  }
  if (typeof data.error !== "undefined") {
    return null
    // return (
    //   <div style={style}>
    //     <Error msg={`Error: ${data.error}`} side="left" />
    //   </div>
    // );
  }
  const displayId = Number(window.location.pathname.replace(/\D+/g, ''));
  const display = data.displays.find(d => d.id === displayId);
  return (
    <div style={style}>
      <Desktop output={data.spaces.filter(s => s.display === display.index)} />
    </div>
  );
};

export default null;
