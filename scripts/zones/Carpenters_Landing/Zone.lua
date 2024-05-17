-----------------------------------
-- Zone: Carpenters_Landing (2)
-----------------------------------
local func = require('scripts/zones/Carpenters_Landing/globals')
local ID = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, 233, -10, -546, 260, 10, -509) -- Barge while docked at South landing
    zone:registerTriggerArea(2, -151, -10, 63, -100, 10, 80)   -- Barge while docked at Central landing
    zone:registerTriggerArea(3, -326, -10, 534, -264, 10, 521) -- Barge while docked at North landing

    UpdateNMSpawnPoint(ID.mob.TEMPEST_TIGON)
    GetMobByID(ID.mob.TEMPEST_TIGON):setRespawnTime(math.random(900, 10800))

    xi.helm.initZone(zone, xi.helmType.LOGGING)
    func.herculesTreeOnGameHour()
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.PHANAUET_CHANNEL then
            cs = xi.barge.onZoneIn(player)
        else
            player:setPos(6.509, -9.163, -819.333, 239)
        end
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onGameHour = function(zone)
    local hour = VanadielHour()

    if hour == 7 or hour == 22 then
        func.herculesTreeOnGameHour()
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    print('triger')
    xi.barge.aboard(player, triggerArea:GetTriggerAreaID(), true)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    xi.barge.aboard(player, triggerArea:GetTriggerAreaID(), false)
end

zoneObject.onTransportEvent = function(player, transport)
    print('transportevent')
    xi.barge.onTransportEvent(player, transport)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 11 then -- North Landing arriving
        player:startEvent(13)
    elseif csid == 10 then -- Central Landing arriving
        player:startEvent(39)
    elseif csid == 38 then -- South Landing arriving
        player:startEvent(12)
    elseif csid == 14 or csid == 16 or csid == 40 then -- Barge departing
        player:setPos(0, 0, 0, 0, xi.zone.PHANAUET_CHANNEL)
    end
end

return zoneObject
