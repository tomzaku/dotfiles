import styles from "./styles.jsx";
import * as Icon from './Icon.jsx'

const containerStyle = {
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  height: 20,
  fontSize: 15,
  // paddingLeft: 6,
};

const desktopStyle = {
  display: "flex",
  // paddingRight: 14,
  // padding: "0 12px 0 0",
  width: 30,
  alignItems: "center",
  justifyContent: "center"
};

const iconMap = [undefined, {
    active: Icon.ChatFilled,
    deactive: Icon.Chat,
  },
  {
    active: Icon.CodeFilled,
    deactive: Icon.Code
  },
  {
    active: Icon.TerminalFilled,
    deactive: Icon.Terminal,
  },
  {
    active: Icon.WebFilled,
    deactive: Icon.Web
  },
  {
    active: Icon.GameFilled,
    deactive: Icon.Game,
  },
  {
    active: Icon.AppFilled,
    deactive: Icon.App
  }
]

const monitorIconMap = [
  undefined,
  {
    active: Icon.WebFilled,
    deactive: Icon.Web
  },
]

const SpaceDefault = ({ index, color }) => <div style={{color}}>{index}</div>

const renderSpace = (index, focused, visible, windows, isMonitor, minIndex) => {
  let contentStyle = JSON.parse(JSON.stringify(desktopStyle));
  if (focused == 1) {
    contentStyle.color = styles.colors.fg;
    contentStyle.fontWeight = "bold";
  } else if (visible == 1) {
    contentStyle.color = styles.colors.fg;
  }
  const status = focused || visible ? 'active' : 'deactive'
  const color = status === 'active' ? '#40FF00' : '#AEAEAE'
  const IconComponent = isMonitor 
    ? (monitorIconMap[index - minIndex + 1] ? monitorIconMap[index - minIndex + 1][status] : SpaceDefault)
    : (iconMap[index] ? iconMap[index][status] : SpaceDefault)
  return (
    <div style={contentStyle}>
     <IconComponent color={color} index={index} />
    </div>
  );
};

const render = ({ output }) => {
  if (typeof output === "undefined") return null;

  const spaces = [];
  const isMonitor = output.map(o => o.index).filter(i => i === 1).length === 0
  const minIndex = Math.min(...output.map(o => o.index))
  output.forEach(function(space) {
    spaces.push(renderSpace(space.index, space.focused, space.visible, space.windows, isMonitor, minIndex));
  });

  return (
    <div style={containerStyle}>
      {spaces}
    </div>
  );
};

export default render;
