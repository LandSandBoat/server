-----------------------------------
-- Zone: The_Ashu_Talif (60)
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
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
