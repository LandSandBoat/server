-----------------------------------
--
-- Zone: Lower_Delkfutts_Tower (184)
--
-----------------------------------
local ID = require("scripts/zones/Lower_Delkfutts_Tower/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, 403, -34, 83, 409, -33, 89) -- Third Floor G-6 porter to Middle Delkfutt's Tower
    zone:registerRegion(2, 390, -34, -49, 397, -33, -43) -- Third Floor F-10 porter to Middle Delkfutt's Tower "1"
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(460.022, -1.77, -103.442, 188)
    end

    if player:getCurrentMission(ACP) == xi.mission.id.acp.BORN_OF_HER_NIGHTMARES and prevZone == xi.zone.QUFIM_ISLAND then
        cs = 34
    end

    return cs
end

zone_object.onRegionEnter = function(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function (x)
            player:setCharVar("option", 1)
            player:startEvent(4)
        end,
        [2] = function (x)
            player:setCharVar("option", 2)
            player:startEvent(4)
        end,
    }
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 4 and option == 1 then
        if player:getCharVar("option") == 1 then
            player:setPos(-28, -48, 80, 111, 157)
        else
            player:setPos(-51, -48, -40, 246, 157)
        end
        player:setCharVar("option", 0)
    elseif csid == 4 and (option == 0 or option >= 3) then
        player:setCharVar("option", 0)
    elseif csid == 34 then
        player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.BORN_OF_HER_NIGHTMARES)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.BANISHING_THE_ECHO)
    end
end

return zone_object
