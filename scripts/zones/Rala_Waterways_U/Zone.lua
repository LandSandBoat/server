-----------------------------------
-- Zone: Rala Waterways U
-----------------------------------
local ID = require('scripts/zones/Rala_Waterways_U/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    local cs = -1

    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, 72)
        return cs
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 1000 and option == 0 then
        player:setPos(-530.6, -5.7, 59.9, 128, xi.zone.RALA_WATERWAYS)
    end
end

zoneObject.onInstanceLoadFailed = function()
    return 258 -- Rala Waterways
end

return zoneObject
