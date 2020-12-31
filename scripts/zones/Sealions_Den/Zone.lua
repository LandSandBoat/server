-----------------------------------
--
-- Zone: Sealions_Den (32)
--
-----------------------------------
local ID = require("scripts/zones/Sealions_Den/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
-----------------------------------

function onInitialize(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(600.101, 130.355, 797.612, 50)
    end
    if player:getCurrentMission(COP) == tpz.mission.id.cop.ONE_TO_BE_FEARED and player:getCharVar("PromathiaStatus") == 1 then
        cs = 15
    elseif (player:getCurrentMission(COP) == tpz.mission.id.cop.CHAINS_AND_BONDS and
        player:getCharVar("PromathiaStatus") == 2) then
        cs = 14
    elseif player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and
        player:getCharVar('ApocalypseNigh') == 1 then
        cs = 29
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 15) then
        player:setCharVar("PromathiaStatus", 2)
    elseif (csid == 14) then
        player:setCharVar("PromathiaStatus", 3);
    elseif csid == 29 then
        player:setCharVar('ApocalypseNigh', 2)
    end
end
