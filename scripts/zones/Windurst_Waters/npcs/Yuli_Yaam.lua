-----------------------------------
-- Area: Windurst Waters
--  NPC: Yuli Yaam
-- Involved In Quest: Wondering Minstrel
-- !pos -61 -4 23 238
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
    fame = player:getFameLevel(WINDURST)
    if (wonderingstatus <= 1 and fame >= 5) then
        player:startEvent(637)                        -- WONDERING_MINSTREL: Quest Available / Quest Accepted
    elseif (wonderingstatus == QUEST_COMPLETED and player:needToZone()) then
        player:startEvent(641)                      -- WONDERING_MINSTREL: Quest After
    else
        rand = math.random(2)
        if (rand == 1) then
            player:startEvent(612)                  -- Standard Conversation 1
        else
            player:startEvent(613)                     -- Standard Conversation 2
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
