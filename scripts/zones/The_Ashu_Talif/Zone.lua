-----------------------------------
-- Zone: The_Ashu_Talif (60)
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onInstanceZoneIn = function(player, instance)
    local cs = -1

    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, 54)
        return cs
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    player:addTempItem(5349)

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option, target)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 102 then
        player:setPos(0, 0, 0, 0, 54)
    end
end

zone_object.onInstanceLoadFailed = function()
    return 54
end

return zone_object
