import { css } from 'uebersicht'


export const command = (dispatch) => {
  const proxy = 'http://127.0.0.1:41417'
  const numberServer = 'http://xkcd.com/info.0.json'
  fetch(`${proxy}/${numberServer}`)
    .then((response) => {
      return response.json()
    })
    .catch((error) => {
      dispatch({
        type: 'FETCH_FAILED',
        error: error.toString()
      })
    })
    .then(data => {
      const rndId = Math.floor(Math.random() * data.num) + 1
      const server = `https://xkcd.com/${rndId}/info.0.json`
      fetch(`${proxy}/${server}`)
        .then(response => response.json())
        .then(xkcd => {
          return dispatch({
            type: 'FETCH_SUCCEDED',
            data: xkcd
          })
        })
    })
}

export const initialState = {
  loading: false,
  showMore: false,
  data: {}
}

export const updateState = (event, previousState) => {
  switch(event.type) {
    case 'FETCH_SUCCEDED': {
      return {
        ...previousState,
        data: event.data,
        loading: true,
      }
    }
    case 'FETCH_FAILED': {
      return {
        ...previousState,
        error: event.error,
      }
    }
    case 'TOGGLE_SHOW': {
      return {...previousState, showMore: !previousState.showMore}
    }
    default: {
      return previousState
    }
  }
}

export const refreshFrequency = 3 * 60 * 60 * 1000 // ms, every 3 hours



export const render = ({ data, showMore }, dispatch ) => {
  const xkcd = data
  return (
    <div className={container} onClick={() => dispatch({type: 'TOGGLE_SHOW'})}>
      {/* {JSON.stringify(data)} */}
      <div className={title}>{xkcd.title}</div>
      {showMore && <img className={image} src={xkcd.img}/>}
      <div className={description}>{xkcd.alt}</div>
    </div>
  )
}

const container = css`
  width : 400px;
  background-color: rgba(60, 60, 60, 0.3);
  border-radius: 10px;
  color: white;
  padding: 10px;
  overflow: hidden;
  font-family: Helvetica Neue;
  bottom: 26px;
  left: 6px;
  position: fixed;

`

const image = css`
  {/* max-width: 30vw; */}
  margin-top: 10px;
  opacity: 0.7;
  max-width: 100%;
`

const title = css`
  font-size: 14px;
  text-transform: uppercase;
  font-weight: bold;
`
const description = css`
  margin-top: 5px;
  
`

