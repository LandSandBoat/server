-----------------------------------
-- Area: Port Windurst
--  NPC: Goltata
--  Involved in Quests: Wonder Wands
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
WonderWands = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WONDER_WANDS)
    if (WonderWands == QUEST_ACCEPTED) then
        player:startEvent(257, 0, 0, 17091)
    elseif (WonderWands == QUEST_COMPLETED) then
        player:startEvent(269)
    else
        player:startEvent(232)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
