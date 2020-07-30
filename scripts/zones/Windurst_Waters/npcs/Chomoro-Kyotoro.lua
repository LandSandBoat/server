-----------------------------------
-- Area: Windurst Waters
--  NPC: Chomoro-Kyotoro
-- Involved in Quest: Making the Grade
-- !pos 133 -5 167 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- needs check for tpz.ki.TATTERED_TEST_SHEET then sets to var 3
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED) then
        local prog = player:getCharVar("QuestMakingTheGrade_prog")
        if (prog == 0) then
            player:startEvent(454)
        elseif (prog == 1) then
            player:startEvent(457)
        elseif (prog == 2) then
            player:startEvent(460)
        else
            player:startEvent(461)
        end
    else
        player:startEvent(432)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 460) then
        player:setCharVar("QuestMakingTheGrade_prog", 3)
        player:delKeyItem(tpz.ki.TATTERED_TEST_SHEET)
    end
end
