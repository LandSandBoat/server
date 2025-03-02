-----------------------------------
-- Zone: Abyssea - Misareaux
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, 599.7, -20, 265, 690, -5, 640)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(670, -15, 318, 119)
    end

    xi.abyssea.onZoneIn(player)

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.abyssea.afterZoneIn(player)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function()
            xi.abyssea.onWardTriggerAreaEnter(player)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function()
            xi.abyssea.onWardTriggerAreaLeave(player)
        end,
    }
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.onEventFinish(player, csid, option, npc)
end

return zoneObject
