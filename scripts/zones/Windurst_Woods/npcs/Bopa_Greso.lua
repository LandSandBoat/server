-----------------------------------
-- Area: Windurst Woods
--  NPC: Bopa Greso
-- Type: Standard NPC
-- !pos 59.773 -6.249 216.766 241
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES) == QUEST_ACCEPTED then
        player:startEvent(506) -- Gambling hint
    else
        player:startEvent(77) -- Standard dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
