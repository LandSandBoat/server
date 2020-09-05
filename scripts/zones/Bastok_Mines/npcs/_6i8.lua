-----------------------------------
-- Area: Bastok Mines
--  NPC: Door
-- Involved in Quest: A Thief in Norg!?
-- !pos 70 7 2 234
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.A_THIEF_IN_NORG) == QUEST_ACCEPTED and player:getCharVar("aThiefinNorgCS") == 3) then
        player:startEvent(186)
        return -1
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 186) then
        player:setCharVar("aThiefinNorgCS", 4)
    end
end
