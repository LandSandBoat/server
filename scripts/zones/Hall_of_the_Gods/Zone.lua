-----------------------------------
--
-- Zone: Hall_of_the_Gods (251)
--
-----------------------------------
local ID = require("scripts/zones/Hall_of_the_Gods/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-0.011, -1.848, -176.133, 192)
    elseif player:getCurrentMission(ACP) == tpz.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS and prevZone == tpz.zone.ROMAEVE then
        cs = 5
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 5 then
        player:completeMission(ACP, tpz.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS)
        player:addMission(ACP, tpz.mission.id.acp.BORN_OF_HER_NIGHTMARES)
    end
end
