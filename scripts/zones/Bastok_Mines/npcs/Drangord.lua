-----------------------------------
-- Area: Bastok Mines
--  NPC: Drangord
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STARDUST) == QUEST_ACCEPTED then
        player:startEvent(97)
    else
        player:startEvent(21)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
