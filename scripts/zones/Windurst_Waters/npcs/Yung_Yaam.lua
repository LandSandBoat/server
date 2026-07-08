-----------------------------------
-- Area: Windurst Waters
--  NPC: Yung Yaam
-- Involved In Quest: Wondering Minstrel
-- !pos -63 -4 27 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wonderingstatus = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)
    local fame = player:getFameLevel(xi.fameArea.WINDURST)
    if wonderingstatus <= 1 and fame >= 5 then
        player:startEvent(637)                        -- WONDERING_MINSTREL: Quest Available / Quest Accepted
    elseif
        wonderingstatus == xi.questStatus.QUEST_COMPLETED and
        player:needToZone()
    then
        player:startEvent(643)                      -- WONDERING_MINSTREL: Quest After
    else
        player:startEvent(609)                      -- Standard Conversation
    end
end

return entity
