-----------------------------------
-- Zone: Maquette Abdhaljs-Legion B (287)
-----------------------------------
local ID = require("scripts/zones/Maquette_Abdhaljs-Legion_B/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onInstanceZoneIn = function(player, instance)
    local cs = -1

    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, 249)
        return cs
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

zone_object.onInstanceLoadFailed = function()
    return 249
end

return zone_object
