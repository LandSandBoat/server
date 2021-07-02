-----------------------------------
--
-- Zone: Leujaoam_Sanctum
--
-----------------------------------
require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onInstanceZoneIn = function(player, instance)
    local cs = -1

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    player:addTempItem(5343)

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 102 then
        player:setPos(0, 0, 0, 0, 79)
    end
end

zone_object.onInstanceLoadFailed = function()
    return 79
end

return zone_object
