-----------------------------------
-- Zone: Vunkerl_Inlet_[S] (83)
-----------------------------------
local ID = require('scripts/zones/Vunkerl_Inlet_[S]/IDs')
require('scripts/globals/status')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-393.238, -50.034, 741.199, 2)
    end

    return cs
end

zoneObject.onZoneWeatherChange = function(weather)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS) -- Indescript Markings

    if npc ~= nil then
        if weather == xi.weather.FOG or weather == xi.weather.THUNDER then
            npc:setStatus(xi.status.DISAPPEAR)
        elseif VanadielHour() >= 16 or VanadielHour() <= 6 then
            npc:setStatus(xi.status.NORMAL)
        end
    end
end

zoneObject.onGameHour = function(zone)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS) -- Indescript Markings

    if npc ~= nil then
        if VanadielHour() == 16 then
            npc:setStatus(xi.status.DISAPPEAR)
        end

        if VanadielHour() == 6 then
            npc:setStatus(xi.status.NORMAL)
        end
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
