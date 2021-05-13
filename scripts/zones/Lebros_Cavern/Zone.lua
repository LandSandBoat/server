-----------------------------------
--
-- Zone: Lebros_Cavern
--
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/status")
require("scripts/globals/zone")
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

    if player:getInstance() ~= nil then
        player:setCharVar("assaultEntered", 3)
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    local instance = player:getInstance()
    local chars = instance:getChars()

    if csid == 102 then
        for _, v in pairs(chars) do
            v:setPos(0, 0, 0, 0, xi.zone.MOUNT_ZHAYOLM)
        end
    end
end

zone_object.onInstanceLoadFailed = function()
    return 61
end

return zone_object
