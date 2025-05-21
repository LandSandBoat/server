-----------------------------------
-- Area: Windurst Waters
--  NPC: Yuli Yaam
-- Involved In Quest: Wondering Minstrel
-- !pos -61 -4 23 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wonderingstatus = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)
    local fame            = player:getFameLevel(xi.fameArea.WINDURST)

    if wonderingstatus <= 1 and fame >= 5 then
        player:startEvent(637)                      -- WONDERING_MINSTREL: Quest Available / Quest Accepted
    elseif
        wonderingstatus == xi.questStatus.QUEST_COMPLETED and
        player:needToZone()
    then
        player:startEvent(641)                      -- WONDERING_MINSTREL: Quest After
    else
        local rand = math.random(1, 2)
        if rand == 1 then
            player:startEvent(612)                  -- Standard Conversation 1
        else
            player:startEvent(613)                  -- Standard Conversation 2
        end
    end
end

return entity
