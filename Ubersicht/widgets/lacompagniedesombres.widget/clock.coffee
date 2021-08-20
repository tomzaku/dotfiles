# remiixinc.github.io
# Help/Suggestions - discord.gg/rTQq4Cs

# Get date from terminal
command: "date +%A,%B,%e,%Y"

# Refresh every 30 seconds
refreshFrequency: 30000 

# Stylesheet
style: """
  
  size = 800px  // The box around the widget

  width: size 
  margin-left: -.5 * size // Set left edge of widget to be center so it can be easily centered on the page
  text-align: center


  height: 130px             
  margin-top: -.5 * 130px
  vertical-align: middle


  // Postition on the screen
  top: 38%
  left: 50%

  // Colours
  primaryColor = rgba(255,255,255,0.99)
  secondaryColor = rgba(255,255,255,0.50)

  #day
    color: primaryColor
    font-size: 100px
    font-family: la Compagnie des Ombres

  #secondary
    font-family: Steelfish
    font-size: 40px
    margin-top: -30px
  	color: secondaryColor
  	  	
  #time
    font-family: Steelfish
    font-size: 120px
    margin-bottom: -60px
  	color: secondaryColor
"""

# HTML for widget
render: (output) -> """
  <div id="time"></div>
  <div>
    <span id ="day"></span>
  </div>
  <div id="secondary"></div>
"""

# Get variables for date input
update: (output) ->
  dateInfo = output.split(',')
  day = dateInfo[0]
  month = dateInfo[1]
  numDate = parseInt(dateInfo[2])
  year = dateInfo[3]
  secondDigit = numDate%10

# Find the suffix for the date
  suffix = switch
  	when numDate is 1 then ' ST'
  	when numDate is 2 then ' ND'
  	when numDate is 3 then ' RD'
  	when numDate < 21 then ' TH'
  	when numDate is 21 then ' ST'
  	when numDate is 22 then ' ND'
  	when numDate is 23 then ' RD'
  	when numDate < 31 then ' TH'
  	when numDate is 31 then ' ST'
  	else 'ERROR'

# Get current time
  date = new Date()
  hours = date.getHours()
  minutes = date.getMinutes()
  if (minutes < 10) then (minutes  = "0" + minutes)

# Layout of the widget with variables
  one = hours + ":" + minutes
  two = day
  three = numDate + suffix + " " + month.toUpperCase() + " " + year

# Add text to widget.
  $('#time').text one
  $('#day').text two
  $('#secondary').text three