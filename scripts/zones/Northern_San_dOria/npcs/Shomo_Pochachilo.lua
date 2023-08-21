-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Shomo Pochachilo
-- !pos 28.369 -0.199 30.061 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO: Verify this, and move to quest script
    local questFatherAndSon = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON)

    if questFatherAndSon == QUEST_COMPLETED then
        player:startEvent(696)
    else
        player:startEvent(675)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
