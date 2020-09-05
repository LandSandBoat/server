-----------------------------------
-- Area: Windurst Waters
--  NPC: Yung Yaam
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
--player:addFame(WINDURST, 100)
    wonderingstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.WONDERING_MINSTREL)
    fame = player:getFameLevel(WINDURST)
    if (wonderingstatus <= 1 and fame >= 5) then
        player:startEvent(637)                        -- WONDERING_MINSTREL: Quest Available / Quest Accepted
    elseif (wonderingstatus == QUEST_COMPLETED and player:needToZone()) then
        player:startEvent(643)                      -- WONDERING_MINSTREL: Quest After
    else
        player:startEvent(609)                      -- Standard Conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
