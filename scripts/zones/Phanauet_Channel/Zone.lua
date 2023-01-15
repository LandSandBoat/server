-----------------------------------
-- Zone: Phanauet_Channel
-----------------------------------
local ID = require('scripts/zones/Phanauet_Channel/IDs')
require('scripts/globals/conquest')
require('scripts/globals/zone')
require('scripts/globals/barge')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    if GetMobByID(ID.mob.STUBBORN_DREDVODD) then
        xi.mob.nmTODPersistCache(zone, ID.mob.STUBBORN_DREDVODD)
    end
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    xi.barge.onZoneIn(player)

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        -- local position = math.random(-2, 2) + 0.15
        player:setPos(0, -3.000, -2.000, 190)
    end

    return cs
end

zoneObject.onGameHour = function(zone)
    local vHour = VanadielHour()
    local death = GetServerVariable("[SPAWN]16781327")
    if vHour == 11 and os.time() > death then
        GetMobByID(ID.mob.STUBBORN_DREDVODD):setRespawnTime(30)
    end
end

zoneObject.onTransportEvent = function(player, transport)
    player:startEvent(100)
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 100 then
        player:setPos(0, 0, 0, 0, xi.zone.CARPENTERS_LANDING)
    end
end

return zoneObject
