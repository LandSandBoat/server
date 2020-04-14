-----------------------------------
-- Area: Empyreal_Paradox
--  NPC: Transcendental Radiance
-- !pos 540 0 -594 36
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/missions");
require("scripts/globals/keyitems");
require("scripts/globals/quests")
require("scripts/globals/bcnm");
-----------------------------------

function onTrade(player,npc,trade)

    if (TradeBCNM(player,npc,trade)) then
        return;
    end

end;

function onTrigger(player,npc)
    --player:addMission(COP, tpz.mission.id.cop.DAWN);
    --player:setCharVar("PromathiaStatus",3)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus")==1) then
        player:startEvent(2)
    elseif player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and player:getCharVar('ApocalypseNigh') == 3 then
        player:startEvent(4)
    elseif (EventTriggerBCNM(player,npc)) then
    end
end

function onEventUpdate(player,csid,option,extras)
    EventUpdateBCNM(player,csid,option,extras)
end

function onEventFinish(player,csid,option)
    if csid == 2 then
        player:setCharVar("PromathiaStatus",2)
    elseif csid == 4 then
        player:setCharVar("ApocalypseNigh", 4)
    elseif EventFinishBCNM(player,csid,option) then
        return
    end
end
