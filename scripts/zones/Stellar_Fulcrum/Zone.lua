-----------------------------------
-- Zone: Stellar_Fulcrum
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -522, -2, -49,  -517, -1, -43) -- To Upper Delkfutt's Tower
    zone:registerCuboidTriggerArea(2, 318, -3, 2,  322, 1, 6) -- Exit BCNM to ?
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
        player:setPos(-519, 1, -33, 193)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function()
            player:startEvent(8)
        end,

        [2] = function()
            player:startEvent(8)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 8 and option == 1 then
        player:setPos(-370, -178, -40, 243, 158)
    end
end

return zoneObject
