-----------------------------------
--
-- Zone: La_Vaule_[S] (85)
--
-----------------------------------
local ID = require("scripts/zones/La_Vaule_[S]/IDs")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(236.547, -2.25, 20, 120)
    end
    if player:getCurrentMission(WOTG) == tpz.mission.id.wotg.A_TIMESWEPT_BUTTERFLY and prevZone == tpz.zone.JUGNER_FOREST_S then
        cs = 1
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 1 then
        player:completeMission(WOTG, tpz.mission.id.wotg.A_TIMESWEPT_BUTTERFLY)
        player:addMission(tpz.mission.log_id.WOTG, tpz.mission.id.wotg.PURPLE_THE_NEW_BLACK)
    end
end
