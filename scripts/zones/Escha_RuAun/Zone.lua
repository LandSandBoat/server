-----------------------------------
-- Zone: Escha_RuAun (289)
-----------------------------------
---@type TZone
local zoneObject = {}

local domainInvasionFence = { pos = { x = 0.0, z = -210.0 }, radius = 25.0 }

zoneObject.onInitialize = function(zone)
    zone:registerCylindricalTriggerArea(1, domainInvasionFence.pos.x, domainInvasionFence.pos.z, domainInvasionFence.radius)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-0.371, -34.277, -466.98, 187)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    if triggerArea:getTriggerAreaID() == 1 then -- Send updates as player moves in the Domain Invasion fence
        xi.domainInvasion.updateFence(player, domainInvasionFence, true)
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    if triggerArea:getTriggerAreaID() == 1 then -- Send updates as player moves out of the Domain Invasion fence
        xi.domainInvasion.updateFence(player, domainInvasionFence, false)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
