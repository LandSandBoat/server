-----------------------------------
-- Area: Bastok Markets
--  NPC: Biggorf
-- Standard Info NPC
-- Involved in Quest: The Bare Bones
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

BareBones = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_BARE_BONES)

    if (BareBones == QUEST_ACCEPTED) then
        player:startEvent(257)
    else
        player:startEvent(126)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
