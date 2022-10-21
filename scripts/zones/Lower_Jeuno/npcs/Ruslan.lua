-----------------------------------
-- Area: Lower Jeuno
--  NPC: Ruslan
-- Involved In Quest: Wondering Minstrel
-- !pos -19 -1 -58 245
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
        local prog = player:getCharVar("QuestWonderingMin_var")
        if prog == 0 then -- WONDERING_MINSTREL + Rosewood Lumber: During Quest / Progression
            player:startEvent(10009, 0, 718)
            player:setCharVar("QuestWonderingMin_var", 1)
        elseif prog == 1 then -- WONDERING_MINSTREL + Rosewood Lumber: Quest Objective Reminder
            player:startEvent(10010, 0, 718)
        end
    elseif wonderingstatus == QUEST_COMPLETED then
        local rand = math.random(1, 3)
        if rand == 1 then
            player:startEvent(10011) -- WONDERING_MINSTREL: After Quest
        else
            player:startEvent(10008) -- Standard Conversation
        end
    else
        player:startEvent(10008) -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
