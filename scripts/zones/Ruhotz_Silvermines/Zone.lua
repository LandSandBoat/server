-----------------------------------
-- Zone: Ruhotz_Silvermines
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, 90)
        return
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 10000 then
        player:setPos(-385.602, 21.970, 456.359, 0, 90)
    end
end

zoneObject.onInstanceLoadFailed = function()
    -- NOTE: This instance has several connection points, and once
    -- utilized should send the the appropriate area on load fail.
end

return zoneObject
