-----------------------------------
-- Zone: Pashhow_Marshlands_[S] (90)
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
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
        player:setPos(547.841, 23.192, 696.323, 134)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onZoneWeatherChange = function(weather)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS_OFFSET + 1) -- Indescript Markings (BOOTS)

    if npc then
        if weather == xi.weather.RAIN or weather == xi.weather.THUNDER then
            npc:setStatus(xi.status.DISAPPEAR)
        else
            npc:setStatus(xi.status.NORMAL)
        end
    end

    npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS_OFFSET + 2) -- Indescript Markings (BODY)
    if npc then
        if weather == xi.weather.RAIN then
            npc:setStatus(xi.status.DISAPPEAR)
        else
            npc:setStatus(xi.status.NORMAL)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
