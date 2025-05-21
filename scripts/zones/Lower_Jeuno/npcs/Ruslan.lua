-----------------------------------
-- Area: Lower Jeuno
--  NPC: Ruslan
-- Involved In Quest: Wondering Minstrel
-- !pos -19 -1 -58 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wonderingstatus = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)

    if wonderingstatus == xi.questStatus.QUEST_ACCEPTED then
        local prog = player:getCharVar('QuestWonderingMin_var')
        if prog == 0 then -- WONDERING_MINSTREL + Rosewood Lumber: During Quest / Progression
            player:startEvent(10009, 0, 718)
            player:setCharVar('QuestWonderingMin_var', 1)
        elseif prog == 1 then -- WONDERING_MINSTREL + Rosewood Lumber: Quest Objective Reminder
            player:startEvent(10010, 0, 718)
        end
    elseif wonderingstatus == xi.questStatus.QUEST_COMPLETED then
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

return entity
