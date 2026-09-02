-----------------------------------
-- Zone: Carpenters_Landing (2)
-----------------------------------
local func = require('scripts/zones/Carpenters_Landing/globals')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -313.76, -15.0,  503.71, -270.63, 2.2,  531.71, -0.7854) -- Barge at north landing
    zone:registerCuboidTriggerArea(2,  232.38, -15.0, -552.54,  260.38, 2.2, -509.42)          -- Barge at south landing
    zone:registerCuboidTriggerArea(3, -145.76, -15.0,   57.95, -102.64, 2.2,   85.95, -0.7854) -- Barge at central landing

    xi.helm.initZone(zone, xi.helmType.LOGGING)
    func.herculesTreeOnGameHour()
end

zoneObject.onZoneTick = function(zone)
    xi.barge.onZoneTick(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.PHANAUET_CHANNEL then
            return xi.barge.onZoneIn(player, prevZone)
        end

        player:setPos(6.509, -9.163, -819.333, 239)
    end

    return -1
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onGameHour = function(zone)
    local hour = VanadielHour()

    if hour == 7 or hour == 22 then
        func.herculesTreeOnGameHour()
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()
    if triggerAreaID <= 3 then
        -- entered one of the Barges
        player:setLocalVar('[barge]aboard', triggerAreaID)
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    player:setLocalVar('[barge]aboard', 0)
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportName)
    xi.barge.onTransportEvent(player, prevZoneId, transportName)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 14 or csid == 16 or csid == 40 then -- Barge departing
        player:setPos(0, 0, 0, 0, xi.zone.PHANAUET_CHANNEL)
    end
end

zoneObject.onZoneOut = function(player)
    xi.helm.onZoneOut(player)
end

return zoneObject
