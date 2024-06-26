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
    zone:registerTriggerArea(2, -113, 30, 84, 0, 0, 0)         -- Barge while docked at Central landing
    zone:registerTriggerArea(3, -278, 30, 527, 0, 0, 0)        -- Barge while docked at North landing

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

            if cs == 11 then -- North Landing arriving
                player:setPos(-302.415, -1.9825, 505.614, 96)
            elseif cs == 10 then -- Central Landing arriving
                player:setPos(-136.983, -1.9688, 60.653, 95)
            elseif cs == 38 then -- South Landing arriving
                player:setPos(230.785, -1.9858, -530.009, 129)
            end
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
    xi.barge.aboard(player, triggerArea:GetTriggerAreaID(), true)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    xi.barge.aboard(player, triggerArea:GetTriggerAreaID(), false)
end

zoneObject.onTransportEvent = function(player, transport)
    xi.barge.onTransportEvent(player, transport)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 11 then -- North Landing arriving
        player:startEvent(17)
    elseif csid == 10 then -- Central Landing arriving
        player:startEvent(41)
    elseif csid == 38 then -- South Landing arriving
        player:startEvent(15)
    elseif csid == 14 or csid == 16 or csid == 40 then -- Barge departing
        player:setPos(0, 0, 0, 0, xi.zone.PHANAUET_CHANNEL)
    end
end

return zoneObject
