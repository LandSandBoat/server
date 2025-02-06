-----------------------------------
-- Zone: Heavens_Tower
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -1, -1, -35, 1, 1, -33)
    zone:registerCuboidTriggerArea(2, 6, -46, -30, 8, -44, -28)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(0, 0, 22, 192)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function()  -- Heaven's Tower exit portal
            player:startEvent(41)
        end,

        [2] = function()  -- Warp directly back to the first floor.
            player:startEvent(83)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 41 then
        player:setPos(0, -17, 135, 60, 239)
    end
end

return zoneObject
