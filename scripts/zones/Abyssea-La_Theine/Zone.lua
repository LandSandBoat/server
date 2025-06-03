-----------------------------------
-- Zone: Abyssea - La_Theine
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -500, -10, 739, -460, 10, 815)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-480.5, -0.5, 794, 62)
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
