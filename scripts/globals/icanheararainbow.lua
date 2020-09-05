-- Functions below used in quest: I Can Hear a Rainbow

require( "scripts/globals/status")
require( "scripts/globals/quests")
require( "scripts/globals/weather")

colorsAvailable = { 102, 103, 104, 105, 106, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 123, 124, 125} -- Zone IDs

-- Data below from http://wiki.ffxiclopedia.org/wiki/I_Can_Hear_a_Rainbow - Feb. 02, 2013

colorsAvailable[100] = { false, true,  false, false, false, false, false} -- West Ronfaure
colorsAvailable[101] = { false, true,  false, false, false, false, false} -- East Ronfaure
colorsAvailable[102] = { false, false, false, true,  true,  false, false} -- La Theine Plateau
colorsAvailable[103] = { true,  false, true,  false, false, false, false} -- Valkurm Dunes
colorsAvailable[104] = { false, false, false, false, true,  false, true } -- Jugner Forest
colorsAvailable[105] = { false, false, true,  false, false, true,  false} -- Batallia Downs
colorsAvailable[106] = { false, true,  false, false, false, false, false} -- North Gustaberg
colorsAvailable[107] = { false, true,  false, false, false, false, false} -- South Gustaberg
colorsAvailable[108] = { false, false, true,  false, false, false, true } -- Konschtat Highlands
colorsAvailable[109] = { false, false, false, false, true,  false, true } -- Pashhow Marshlands
colorsAvailable[110] = { true,  false, false, false, true,  false, false} -- Rolanberry Fields
colorsAvailable[111] = { false, false, false, false, false, true,  false} -- Beaucedine Glacier
colorsAvailable[112] = { false, false, false, false, false, true,  false} -- Xarcabard
colorsAvailable[113] = { true,  false, false, true,  false, false, false} -- Cape Teriggan
colorsAvailable[114] = { true,  true,  true,  false, false, false, false} -- Eastern Altepa Desert
colorsAvailable[115] = { false, true,  false, false, false, false, false} -- West Sarutabaruta
colorsAvailable[116] = { false, true,  false, false, false, false, false} -- East Sarutabaruta
colorsAvailable[117] = { false, false, true,  true,  false, false, false} -- Tahrongi Canyon
colorsAvailable[118] = { false, true,  false, true,  true,  false, false} -- Buburimu Peninsula
colorsAvailable[119] = { true,  false, true,  false, false, false, false} -- Meriphataud Mountains
colorsAvailable[120] = { false, false, true,  false, false, false, true } -- Sauromugue Champaign
colorsAvailable[121] = { false, false, false, false, true,  false, true } -- The Sanctuary of Zi'Tah
colorsAvailable[123] = { true,  false, false, false, true,  false, false} -- Yuhtunga Jungle
colorsAvailable[124] = { true,  true,  false, false, true,  false, false} -- Yhoator Jungle
colorsAvailable[125] = { true,  false, true,  false, false, false, false} -- Western Altepa Desert

-- The Event IDs to trigger the light cutscene for the following 3 zones is currently unknown.
-- They are included only because they are listed at http://wiki.ffxiclopedia.org/wiki/I_Can_Hear_a_Rainbow

-- colorsAvailable[128] = { false, false, false, true,  false, false, false} -- Valley of Sorrows
-- colorsAvailable[136] = { false, false, false, false, false, true,  false} -- Beaucedine Glacier (S)
-- colorsAvailable[205] = { true,  false, false, false, false, false, false} -- Ifrit's Cauldron

-----------------------------------
-- triggerLightCutscene
-----------------------------------

function triggerLightCutscene( player)
    local cutsceneTriggered = false
    local RED    = 1
    local ORANGE = 2
    local YELLOW = 3
    local GREEN  = 4
    local BLUE   = 5
    local INDIGO = 6
    local VIOLET = 7
    local zone   = player:getZoneID()
    local weather = player:getWeather()

    if (player:hasItem( 1125, 0)) then -- Player has Carbuncle's Ruby?
        if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.I_CAN_HEAR_A_RAINBOW) == QUEST_ACCEPTED) then
            if (player:getMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), 0) == false and (weather == tpz.weather.HOT_SPELL or weather == tpz.weather.HEAT_WAVE)) then
                if (colorsAvailable[zone][RED]) then
                    cutsceneTriggered = true
                    player:setMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), "I_CAN_HEAR_A_RAINBOW", 0, true)
                    player:setCharVar( "I_CAN_HEAR_A_RAINBOW_Weather", weather)
                end
            elseif (player:getMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), 1) == false and (weather == tpz.weather.NONE or weather == tpz.weather.SUNSHINE)) then
                if (colorsAvailable[zone][ORANGE]) then
                    cutsceneTriggered = true
                    player:setMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), "I_CAN_HEAR_A_RAINBOW", 1, true)
                    player:setCharVar( "I_CAN_HEAR_A_RAINBOW_Weather", weather)
                end
            elseif (player:getMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), 2) == false and (weather == tpz.weather.DUST_STORM or weather == tpz.weather.SAND_STORM)) then
                if (colorsAvailable[zone][YELLOW]) then
                    cutsceneTriggered = true
                    player:setMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), "I_CAN_HEAR_A_RAINBOW", 2, true)
                    player:setCharVar( "I_CAN_HEAR_A_RAINBOW_Weather", weather)
                end
            elseif (player:getMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), 3)  == false and (weather == tpz.weather.WIND or weather == tpz.weather.GALES)) then
                if (colorsAvailable[zone][GREEN]) then
                    cutsceneTriggered = true
                    player:setMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), "I_CAN_HEAR_A_RAINBOW", 3, true)
                    player:setCharVar( "I_CAN_HEAR_A_RAINBOW_Weather", weather)
                end
            elseif (player:getMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), 4)   == false and (weather == tpz.weather.RAIN or weather == tpz.weather.SQUALL)) then
                if (colorsAvailable[zone][BLUE]) then
                    cutsceneTriggered = true
                    player:setMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), "I_CAN_HEAR_A_RAINBOW", 4, true)
                    player:setCharVar( "I_CAN_HEAR_A_RAINBOW_Weather", weather)
                end
            elseif (player:getMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), 5) == false and (weather == tpz.weather.SNOW or weather == tpz.weather.BLIZZARDS)) then
                if (colorsAvailable[zone][INDIGO]) then
                    cutsceneTriggered = true
                    player:setMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), "I_CAN_HEAR_A_RAINBOW", 5, true)
                    player:setCharVar( "I_CAN_HEAR_A_RAINBOW_Weather", weather)
                end
            elseif (player:getMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), 6) == false and (weather == tpz.weather.THUNDER or weather == tpz.weather.THUNDERSTORMS)) then
                if (colorsAvailable[zone][VIOLET]) then
                    cutsceneTriggered = true
                    player:setMaskBit(player:getCharVar("I_CAN_HEAR_A_RAINBOW"), "I_CAN_HEAR_A_RAINBOW", 6, true)
                    player:setCharVar( "I_CAN_HEAR_A_RAINBOW_Weather", weather)
                end
            end
        end
    end

    return cutsceneTriggered
end

-----------------------------------
-- lightCutsceneUpdate
-----------------------------------

function lightCutsceneUpdate( player)
    local weather = player:getCharVar( "I_CAN_HEAR_A_RAINBOW_Weather")

    if (weather == tpz.weather.SUNSHINE) then -- In some zones the light cutscene does not handle tpz.weather.SUNSHINE properly
        weather = tpz.weather.NONE
    end

    if (player:getCharVar("I_CAN_HEAR_A_RAINBOW") < 127) then
        player:updateEvent( 0, 0, weather)
    else
        player:updateEvent( 0, 0, weather, 6)
    end
end

-----------------------------------
-- lightCutsceneFinish
-----------------------------------

function lightCutsceneFinish( player)
    player:setCharVar("I_CAN_HEAR_A_RAINBOW_Weather", 0)
end
