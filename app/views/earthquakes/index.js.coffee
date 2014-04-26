$(".earthquakes").html("<%= escape_javascript(render('earthquakes')) %>")

$(".earthquakes_loading").hide()
$(".earthquakes").show()
