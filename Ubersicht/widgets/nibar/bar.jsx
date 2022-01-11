import styles from "./lib/styles.jsx";

const style = {
  background: styles.colors.bg,
  cursor: "default",
  userSelect: "none",
  zIndex: "-1",
  width: "100%",
  height: "30px",
  position: "fixed",
  overflow: "hidden",
  bottom: "0px",
  right: "0px",
  left: "0px"
};

export const refreshFrequency = 1000000;

export const render = () => {
  return <div style={style} />;
};

export default null;
