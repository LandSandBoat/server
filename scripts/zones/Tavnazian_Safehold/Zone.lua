-----------------------------------
-- Zone: Tavnazian_Safehold (26)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- NOTE: On Retail, Trigger Area 1 appears to be a cylindrical area (no Z-axis) that is quite large.  Managed to trigger
    -- it on the top floor while moving up the ramp from homepoint.
    zone:registerCuboidTriggerArea(1, -5, -24, 18, 5, -20, 27)
    zone:registerCuboidTriggerArea(2, 104, -42, -88, 113, -38, -77)
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
        player:setPos(-4, -26, 134, 87)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
