-----------------------------------
-- Zone: Upper_Delkfutts_Tower (158)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -369, -146, 83,  -365, -145,  89) -- Tenth Floor F-6 porter to Middle Delkfutt's Tower
    zone:registerCuboidTriggerArea(2, -369, -178, -49, -365, -177, -43) -- Twelfth Floor F-10 porter to Stellar Fulcrum

    xi.treasure.initZone(zone)
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
        player:setPos(12.098, -105.408, 27.683, 239)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function()
            --player:setCharVar('porter_lock', 1)
            player:startEvent(0)
        end,

        [2] = function()
            --player:setCharVar('porter_lock', 1)
            player:startEvent(1)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 0 and option == 1 then
        player:setPos(-490, -130, 81, 231, 157)
    elseif csid == 1 and option == 1 then
        player:setPos(-520, 1, -23, 192, 179) -- to Stellar Fulcrum
    end
end

return zoneObject
