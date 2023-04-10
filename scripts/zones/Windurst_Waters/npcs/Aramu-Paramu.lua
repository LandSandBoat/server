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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wonderingstatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)

    if wonderingstatus == QUEST_ACCEPTED then
        player:startEvent(638)                        -- WONDERING_MINSTREL: Quest Available / Quest Accepted
    elseif wonderingstatus == QUEST_COMPLETED and player:needToZone() then
        player:startEvent(641)                      -- WONDERING_MINSTREL: Quest After
    else
        player:startEvent(609)                          -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
