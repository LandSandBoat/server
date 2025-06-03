-----------------------------------
-- Zone: La_Theine_Plateau (102)
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
local laTheineGlobal = require('scripts/zones/La_Theine_Plateau/globals')
require('scripts/quests/i_can_hear_a_rainbow')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    laTheineGlobal.moveFallenEgg()
    xi.chocobo.initZone(zone)
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-559, 0, 680, 73)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 123
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.chocoboGame.handleMessage(player)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 123 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onZoneWeatherChange = function(weather)
    local rainbow = GetNPCByID(ID.npc.RAINBOW)
    if not rainbow then
        return
    end

    local timeOfTheDay = VanadielTOTD()
    local setRainbow   = rainbow:getLocalVar('setRainbow')
    if
        setRainbow == 1 and
        weather ~= xi.weather.RAIN and
        timeOfTheDay >= xi.time.DAWN and
        timeOfTheDay <= xi.time.EVENING and
        rainbow:getAnimation() == xi.anim.CLOSE_DOOR
    then
        rainbow:setAnimation(xi.anim.OPEN_DOOR)
    elseif
        setRainbow == 1 and
        weather == xi.weather.RAIN and
        rainbow:getAnimation() == xi.anim.OPEN_DOOR
    then
        rainbow:setAnimation(xi.anim.CLOSE_DOOR)
        rainbow:setLocalVar('setRainbow', 0)
    end
end

zoneObject.onTOTDChange = function(timeOfTheDay)
    local rainbow = GetNPCByID(ID.npc.RAINBOW)
    if not rainbow then
        return
    end

    local setRainbow = rainbow:getLocalVar('setRainbow')

    if
        setRainbow == 1 and
        timeOfTheDay >= xi.time.DAWN and
        timeOfTheDay <= xi.time.EVENING and
        rainbow:getAnimation() == xi.anim.CLOSE_DOOR
    then
        rainbow:setAnimation(xi.anim.OPEN_DOOR)
    elseif
        setRainbow == 1 and
        timeOfTheDay < xi.time.DAWN or
        timeOfTheDay > xi.time.EVENING and
        rainbow:getAnimation() == xi.anim.OPEN_DOOR
    then
        rainbow:setAnimation(xi.anim.CLOSE_DOOR)
        rainbow:setLocalVar('setRainbow', 0)
    end
end

return zoneObject
