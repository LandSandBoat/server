-----------------------------------
-- Area: Windurst Waters
--  NPC: Aramu-Paramu
-- Involved In Quest: Wondering Minstrel
-- !pos -63 -4 27 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wonderingstatus = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)

    if wonderingstatus == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(638)                        -- WONDERING_MINSTREL: Quest Available / Quest Accepted
    elseif
        wonderingstatus == xi.questStatus.QUEST_COMPLETED and
        player:needToZone()
    then
        player:startEvent(641)                      -- WONDERING_MINSTREL: Quest After
    else
        player:startEvent(609)                          -- Standard Conversation
    end
end

return entity
