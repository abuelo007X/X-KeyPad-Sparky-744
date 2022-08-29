-- @Abuelo007X notes:
--- 2022-01-23:
---- Just variable drawing on the screen.

function variables_drawing()
    draw_string(50,120,"DESCRIPTION '" .. PLANE_DESCRIP .. "'","red")
    draw_string(50,100,"ICAO '" .. PLANE_ICAO .. "'","red")
    draw_string(50,80,"TAILNUMBER '" .. PLANE_TAILNUMBER .. "'","red")
    draw_string(50,60,"AUTHOR '" .. PLANE_AUTHOR .. "'","red")
    draw_string(50,40,"PATH '" .. AIRCRAFT_PATH .. "'","red")
    draw_string(50,20,"FILENAME '" .. AIRCRAFT_FILENAME .. "'","red")
end

do_every_draw("variables_drawing()")