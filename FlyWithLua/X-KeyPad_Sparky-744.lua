-- @Abuelo007X notes:
--- 2022-01-23:
---- FlyWithLua script used in conjunction with X-KeyPad Virtual Device configuration file for the Sparky 744 Mod
---- Please refer to README.md for additional information


-- Sparky 744 does not have an assigned TAILNUMBER. Using it for validation to differentiate it from Laminar Default 744 which has a predefined TAILNUMBER
if(PLANE_ICAO == "B744" and PLANE_TAILNUMBER == "") then
    	-- X-KeyPad Custom Strings or Values
    local SHAREDINT = dataref_table("SRS/X-KeyPad/SharedInt")

    -- Simulator datarefs
    local ENG_FUEL_PRESS = dataref_table("sim/cockpit/warnings/annunciators/fuel_pressure_low")
    local GEN_STATUS = dataref_table("sim/cockpit/warnings/annunciators/generator_off")
    local BUS_VOLTAGE_VALUE = dataref_table("sim/cockpit2/electrical/bus_volts") -- Power bus voltage value
    local SWITCH_POS = dataref_table("laminar/B747/button_switch/position")
    dataref("BATTERY_STAT","sim/cockpit/electrical/battery_on") -- Battery Status
    dataref("ENG_FUEL_1_POS","laminar/B747/hydraulics/valve_1") -- Engine fuel valve position 1
    dataref("ENG_FUEL_2_POS","laminar/B747/hydraulics/valve_2") -- Engine fuel valve position 2
    dataref("ENG_FUEL_3_POS","laminar/B747/hydraulics/valve_3") -- Engine fuel valve position 3
    dataref("ENG_FUEL_4_POS","laminar/B747/hydraulics/valve_4") -- Engine fuel valve position 4
    dataref("PUMP_DEM_1_POS","laminar/B747/hydraulics/dem_mode_1") -- Pump demand position 1
    dataref("PUMP_DEM_2_POS","laminar/B747/hydraulics/dem_mode_2") -- Pump demand position 2
    dataref("PUMP_DEM_3_POS","laminar/B747/hydraulics/dem_mode_3") -- Pump demand position 3
    dataref("PUMP_DEM_4_POS","laminar/B747/hydraulics/dem_mode_4") -- Pump demand position 4
    local PUMP_DEM_POS = dataref_table("laminar/B747/hydraulics/dmd_pump/sel_dial_pos")
    dataref("PUMP_DEM_1_PRESS","laminar/B747/hydraulics/dem_pressure_1") -- Pump demand pressure 1
    dataref("PUMP_DEM_2_PRESS","laminar/B747/hydraulics/dem_pressure_2") -- Pump demand pressure 2
    dataref("PUMP_DEM_3_PRESS","laminar/B747/hydraulics/dem_pressure_3") -- Pump demand pressure 3
    dataref("PUMP_DEM_4_PRESS","laminar/B747/hydraulics/dem_pressure_4") -- Pump demand pressure 4
    
    -- local variables
    local temp_value=0 -- to store calculated value to compare vs previous value
    local efvp="0" -- To be used for the engine fuel valve position. 0 OFF | 1 ON
    local efpa="0" -- To be used for the engine fuel pressure annunciator. 1 LOW PRESSURE | 0 OK
    local batts="0" -- To be used for the battery status. 0 OFF | 1 ON
    local power="0" -- To be used for voltage value. 0 POWER OFF | 1 POWER ON
    local gen_st="0" -- To be used for generatos status. 0 ON | 1 OFF
    local switch_pos="0" -- To be used to capture switch position. values will vary depending on the switch
    local pump_dem_p="0"

    -- Set SharedInt Engine Fuel pressure current value
    SHAREDINT[0] = ENG_FUEL_PRESS[0]
    SHAREDINT[1] = ENG_FUEL_PRESS[1]
    SHAREDINT[2] = ENG_FUEL_PRESS[2]
    SHAREDINT[3] = ENG_FUEL_PRESS[3]

    -- to store SharedInt previous value for comparison
    local efv1 = SHAREDINT[0]
    local efv2 = SHAREDINT[1]
    local efv3 = SHAREDINT[2]
    local efv4 = SHAREDINT[3]
    local bt1 = SHAREDINT[4]
    local bt2 = SHAREDINT[5]
    local bt3 = SHAREDINT[6]
    local bt4 = SHAREDINT[7]
    local gc1 = SHAREDINT[8]
    local gc2 = SHAREDINT[9]
    local gc3 = SHAREDINT[10]
    local gc4 = SHAREDINT[11]
    local pdp1 = SHAREDINT[12]
    local pdp2 = SHAREDINT[13]
    local pdp3 = SHAREDINT[14]
    local pdp4 = SHAREDINT[15]

    function s744_function()
        -- Common actions
        batts = string.format("%0d",BATTERY_STAT)

        if BUS_VOLTAGE_VALUE[0] > 0 then
		    power = string.format("%0d",1)
        else
            power = string.format("%0d",0)
        end

        -- STARTS ENGINE FUEL 1 Section
        --- Format the values for future usage as binary in case of innacurate format (0 or 1)
        efvp = string.format("%0d",ENG_FUEL_1_POS)
		efpa = string.format("%0d",ENG_FUEL_PRESS[0])

        --- Concanate the values and convert to a binary value then store in ShareInt position if value changed, and update new value for future validation
        temp_value = tonumber(efvp..efpa..power,2)

        if efv1 ~= temp_value then 
            SHAREDINT[0] = temp_value
            efv1 = temp_value
        end
        -- ENDS ENGINE FUEL 1 Section

        -- STARTS ENGINE FUEL 2 Section
        --- Format the values for future usage as binary in case of innacurate format (0 or 1)
        efvp = string.format("%0d",ENG_FUEL_2_POS)
		efpa = string.format("%0d",ENG_FUEL_PRESS[1])

        --- Concanate the values and convert to a binary value then store in ShareInt position if value changed, and update new value for future validation
        temp_value = tonumber(efvp..efpa..power,2)

        if efv2 ~= temp_value then 
            SHAREDINT[1] = temp_value
            efv2 = temp_value
        end
        -- ENDS ENGINE FUEL 2 Section

        -- STARTS ENGINE FUEL 3 Section
        --- Format the values for future usage as binary in case of innacurate format (0 or 1)
        efvp = string.format("%0d",ENG_FUEL_3_POS)
		efpa = string.format("%0d",ENG_FUEL_PRESS[2])

        --- Concanate the values and convert to a binary value then store in ShareInt position if value changed, and update new value for future validation
        temp_value = tonumber(efvp..efpa..power,2)

        if efv3 ~= temp_value then 
            SHAREDINT[2] = temp_value
            efv3 = temp_value
        end
        -- ENDS ENGINE FUEL 3 Section

        -- STARTS ENGINE FUEL 4 Section
        --- Format the values for future usage as binary in case of innacurate format (0 or 1)
        efvp = string.format("%0d",ENG_FUEL_4_POS)
		efpa = string.format("%0d",ENG_FUEL_PRESS[3])

        --- Concanate the values and convert to a binary value then store in ShareInt position if value changed, and update new value for future validation
        temp_value = tonumber(efvp..efpa..power,2)

        if efv4 ~= temp_value then 
            SHAREDINT[3] = temp_value
            efv4 = temp_value
        end
        -- ENDS ENGINE FUEL 4 Section

        -- STARTS BUS TIE 1 Section
        if SWITCH_POS[18] > 0 then
		    switch_pos = string.format("%0d",1)
        else
            switch_pos = string.format("%0d",0)
        end
        
        temp_value = tonumber(switch_pos..power,2)

        if bt1 ~= temp_value then 
            SHAREDINT[4] = temp_value
            bt1 = temp_value
        end
        -- ENDS BUS TIE 1 Section

        -- STARTS BUS TIE 2 Section
        if SWITCH_POS[19] > 0 then
		    switch_pos = string.format("%0d",1)
        else
            switch_pos = string.format("%0d",0)
        end
        
        temp_value = tonumber(switch_pos..power,2)

        if bt2 ~= temp_value then 
            SHAREDINT[5] = temp_value
            bt2 = temp_value
        end
        -- ENDS BUS TIE 2 Section

        -- STARTS BUS TIE 3 Section
        if SWITCH_POS[20] > 0 then
		    switch_pos = string.format("%0d",1)
        else
            switch_pos = string.format("%0d",0)
        end
        
        temp_value = tonumber(switch_pos..power,2)

        if bt3 ~= temp_value then 
            SHAREDINT[6] = temp_value
            bt3 = temp_value
        end
        -- ENDS BUS TIE 3 Section

        -- STARTS BUS TIE 4 Section
        if SWITCH_POS[21] > 0 then
		    switch_pos = string.format("%0d",1)
        else
            switch_pos = string.format("%0d",0)
        end
        
        temp_value = tonumber(switch_pos..power,2)

        if bt4 ~= temp_value then 
            SHAREDINT[7] = temp_value
            bt4 = temp_value
        end
        -- ENDS BUS TIE 4 Section

        -- STARTS GEN CONT 1 Section
        if SWITCH_POS[22] > 0 then
		    switch_pos = string.format("%0d",1)
        else
            switch_pos = string.format("%0d",0)
        end
        gen_st = string.format("%0d",GEN_STATUS[0])

        temp_value = tonumber(switch_pos..gen_st..power,2)

        if gc1 ~= temp_value then 
            SHAREDINT[8] = temp_value
            gc1 = temp_value
        end
        -- ENDS GEN CONT 1 Section

        -- STARTS GEN CONT 2 Section
        if SWITCH_POS[23] > 0 then
		    switch_pos = string.format("%0d",1)
        else
            switch_pos = string.format("%0d",0)
        end
        gen_st = string.format("%0d",GEN_STATUS[1])

        temp_value = tonumber(switch_pos..gen_st..power,2)

        if gc2 ~= temp_value then 
            SHAREDINT[9] = temp_value
            gc2 = temp_value
        end
        -- ENDS GEN CONT 2 Section

        -- STARTS GEN CONT 3 Section
        if SWITCH_POS[24] > 0 then
		    switch_pos = string.format("%0d",1)
        else
            switch_pos = string.format("%0d",0)
        end
        gen_st = string.format("%0d",GEN_STATUS[2])

        temp_value = tonumber(switch_pos..gen_st..power,2)

        if gc3 ~= temp_value then 
            SHAREDINT[10] = temp_value
            gc3 = temp_value
        end
        -- ENDS GEN CONT 3 Section

        -- STARTS GEN CONT 4 Section
        if SWITCH_POS[25] > 0 then
		    switch_pos = string.format("%0d",1)
        else
            switch_pos = string.format("%0d",0)
        end
        gen_st = string.format("%0d",GEN_STATUS[3])

        temp_value = tonumber(switch_pos..gen_st..power,2)

        if gc4 ~= temp_value then 
            SHAREDINT[11] = temp_value
            gc4 = temp_value
        end
        -- ENDS GEN CONT 4 Section

        -- STARTS DEMAND PUMP 2 Section
        if PUMP_DEM_POS[3] == 0 then
		    switch_pos = string.format("%02d",1)
        elseif PUMP_DEM_POS[3] == 1 then
		    switch_pos = string.format("%02d",10)
        elseif PUMP_DEM_POS[3] == 2 then
		    switch_pos = string.format("%02d",11)
        else
		    switch_pos = string.format("%02d",0)
        end
		draw_string(50,1250,switch_pos,"red")

        if PUMP_DEM_4_PRESS > 0 then
		    pump_dem_p = string.format("%0d",1)
        else
		    pump_dem_p = string.format("%0d",0)
        end

        temp_value = tonumber(switch_pos..pump_dem_p..power,2)
		draw_string(50,1200,switch_pos..pump_dem_p..power.." : "..temp_value,"red")

        if pdp4 ~= temp_value then 
            SHAREDINT[16] = temp_value
            pdp4 = temp_value
        end
        -- ENDS DEMAND PUMP 2 Section
    end

    do_every_draw("s744_function()")
end