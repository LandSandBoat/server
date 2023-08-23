-----------------------------------
-- Area: Windurst Waters
--  NPC: Yung Yaam
-- Involved In Quest: Wondering Minstrel
-- !pos -63 -4 27 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wonderingstatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)
    local fame = player:getFameLevel(xi.quest.fame_area.WINDURST)
    if wonderingstatus <= 1 and fame >= 5 then
        player:startEvent(637)                        -- WONDERING_MINSTREL: Quest Available / Quest Accepted
    elseif wonderingstatus == QUEST_COMPLETED and player:needToZone() then
        player:startEvent(643)                      -- WONDERING_MINSTREL: Quest After
    else
        player:startEvent(609)                      -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
