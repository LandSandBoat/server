-----------------------------------
--
-- Zone: Escha - Zi'Tah (288)
--
-----------------------------------
local ID = require("scripts/zones/Escha_ZiTah/IDs")
require("scripts/globals/missions")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        -- player:setPos(x, y, z, rot)
    end

    if player:getCurrentMission(ROV) == tpz.mission.id.rov.EDDIES_OF_DESPAIR_I then
        cs = 1
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 1 then
        player:completeMission(ROV,tpz.mission.id.rov.EDDIES_OF_DESPAIR_I)
        player:addMission(tpz.mission.log_id.ROV,tpz.mission.id.rov.A_LAND_AFTER_TIME)
    end
end
