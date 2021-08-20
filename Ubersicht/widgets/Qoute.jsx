import { css } from 'uebersicht'

export const refreshFrequency = 1 * 60 * 60 * 1000 // ms, every hour

export const command = `fortune -s`

export const render = ({ output }) => {
  return (
    <div className={container}>
      <span className={qoute}>“</span>{output}<span className={endQoute}>„</span>
    </div>
  )
}

export const className = `
  left: 50%;
  top: 38%;
  transform: translate(-50%,-38%);
  text-align: center;
  color: rgba(255,255,255,0.80);
  font-family: Steelfish;
  max-width: 800px;
`

const container = css`
  margin-top: 250px;
  background-color: rgba(0,0,0,0.4);
  border-radius: 6px;
  padding: 5px 16px;
  font-size: 14px;
  font-family: Helvetica Neue;
  position: relative;
`

const qoute = css`
  font-size: 32px;
  position: absolute;
  left: -6px;
  color: rgba(255,255,255,0.6);
  top: -10px;
`

const endQoute = css`
  font-size: 32px;
  position: absolute;
  right: -6px;
  color: rgba(255,255,255,0.6);
  bottom: -6px;
`
