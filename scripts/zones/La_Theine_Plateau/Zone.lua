-----------------------------------
-- Zone: La_Theine_Plateau (102)
-----------------------------------
local ID = require('scripts/zones/La_Theine_Plateau/IDs')
local laTheineGlobal = require('scripts/zones/La_Theine_Plateau/globals')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/settings')
require('scripts/globals/chocobo')
require('scripts/globals/quests')
require('scripts/globals/status')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

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

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 123 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option)
end

zoneObject.onZoneWeatherChange = function(weather)
    local rainbow = GetNPCByID(ID.npc.RAINBOW)
    local timeOfTheDay = VanadielTOTD()
    local setRainbow = rainbow:getLocalVar("setRainbow")

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
    local setRainbow = rainbow:getLocalVar("setRainbow")

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
