-----------------------------------
-- Zone: Windurst_Walls (239)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -2, -17, 140, 2, -16, 142)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(1, 5) - 123
        player:setPos(-257.5, -5.05, position, 0)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function()  -- Heaven's Tower enter portal
            player:startEvent(86)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 86 then
        player:setPos(0, 0, -22.40, 192, 242)
    end
end

return zoneObject
