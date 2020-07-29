-----------------------------------
-- Area: Windurst Waters
--  NPC: Aramu-Paramu
-- Involved In Quest: Wondering Minstrel
-- !pos -63 -4 27 238
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    wonderingstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WONDERING_MINSTREL)
    if (wonderingstatus == QUEST_ACCEPTED) then
        player:startEvent(638)                        -- WONDERING_MINSTREL: Quest Available / Quest Accepted
    elseif (wonderingstatus == QUEST_COMPLETED and player:needToZone()) then
        player:startEvent(641)                      -- WONDERING_MINSTREL: Quest After
    else
        player:startEvent(609)                          -- Standard Conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
