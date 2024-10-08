-----------------------------------
-- Zone: Rala Waterways U
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, 72)
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
    if csid == 1000 and option == 0 then
        player:setPos(-530.6, -5.7, 59.9, 128, xi.zone.RALA_WATERWAYS)
    end
end

zoneObject.onInstanceLoadFailed = function()
    return xi.zone.RALA_WATERWAYS
end

return zoneObject
