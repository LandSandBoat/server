-----------------------------------
-- Zone: Carpenters_Landing (2)
-----------------------------------
local func = require('scripts/zones/Carpenters_Landing/globals')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- TODO create a registerRotatedCuboidTriggerArea binding
    -- barge is a large rectangle with barely any plank, but 2 of the docks don't face a cardinal direction.
    -- cylinder technically can encompass the whole boat but it's not optimal and requires precision center/radius selection
    zone:registerCylindricalTriggerArea(1, -274.5, 532.4, 38)        -- Barge at north landing
    zone:registerCuboidTriggerArea(2, 232, -15, -555, 270, 15, -500) -- Barge at south landing
    zone:registerCylindricalTriggerArea(3, -108, 88.5, 38)           -- Barge at central landing

    xi.helm.initZone(zone, xi.helmType.LOGGING)
    func.herculesTreeOnGameHour()
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

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    xi.barge.onTransportEvent(player, prevZoneId, transportId)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 14 or csid == 16 or csid == 40 then -- Barge departing
        player:setPos(0, 0, 0, 0, xi.zone.PHANAUET_CHANNEL)
    end
end

return zoneObject
