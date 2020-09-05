-----------------------------------
-- Area: Port Bastok
--  NPC: Tete
-- Continues Quest: The Wisdom Of Elders
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_WISDOM_OF_ELDERS) == QUEST_ACCEPTED) then
        player:startEvent(175)
    else
        player:startEvent(35)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 175) then
        player:setCharVar("TheWisdomVar", 2)
    end

end
