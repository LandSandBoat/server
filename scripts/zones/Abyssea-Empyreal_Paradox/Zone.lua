-----------------------------------
-- Zone: Abyssea - Empyreal_Paradox
-----------------------------------
---@type TZone
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
        player:setPos(540, -500, -571, 64)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    if not player:hasStatusEffect(xi.effect.VISITANT) then
        player:addStatusEffect(xi.effect.VISITANT, { icon = xi.effect.VISITANT, origin = player })
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
