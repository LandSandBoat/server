-----------------------------------
-- Zone: Riverne-Site_B01
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(729.749, -20.319, 407.153, 90)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    -- ZONE WIDE LEVEL RESTRICTION
    if xi.settings.main.ENABLE_COP_ZONE_CAP == 1 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 50, 0, 0)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
