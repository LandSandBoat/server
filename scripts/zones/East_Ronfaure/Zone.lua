-----------------------------------
--
-- Zone: East_Ronfaure (101)
--
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest");
require("scripts/globals/quests")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(200.015, -3.187, -536.074, 187)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 21
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==
        1) then
        cs = 23
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if csid == 21 then
        quests.rainbow.onEventUpdate(player)
    elseif (csid == 23) then
        if (player:getYPos() >= -22) then
            player:updateEvent(0, 0, 0, 0, 0, 7)
        else
            player:updateEvent(0, 0, 0, 0, 0, 6)
        end
    end
end

function onEventFinish(player, csid, option)
end
