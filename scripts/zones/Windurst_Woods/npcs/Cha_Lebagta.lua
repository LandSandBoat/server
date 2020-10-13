-----------------------------------
-- Area: Windurst Woods
--  NPC: Cha Lebagta
-- Type: Standard NPC
-- !pos 58.385 -6.249 216.670 241
-- Involved in Quests: As Thick as Thieves, Mihgo's Amigo
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local mihgosAmigo = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MIHGO_S_AMIGO)

    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES) == QUEST_ACCEPTED then
        player:startEvent(507, 0, 17474) -- Grappling hint
    elseif mihgosAmigo == QUEST_ACCEPTED then
        player:startEvent(85, 0, 498) -- Migho's Amigo hint dialog
    elseif mihgosAmigo == QUEST_COMPLETED then
        player:startEvent(91, 0, 498) -- New standard dialog after Mihgo's Amigo completion
    else
        player:startEvent(78) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
