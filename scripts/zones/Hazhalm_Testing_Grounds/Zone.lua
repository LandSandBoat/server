-----------------------------------
--
-- Zone: Hazhalm_Testing_Grounds (78)
--
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/settings")
local ID = require("scripts/zones/Hazhalm_Testing_Grounds/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(652.174, -272.632, -104.92, 148)
    end

    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.GAZE_OF_THE_SABOTEUR and player:getCharVar("AhtUrganStatus") == 0) then
        cs = 6
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 6) then
        player:setCharVar("AhtUrganStatus", 1)
    end
end
