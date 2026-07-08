-----------------------------------
-- Area: Western Adoulin
--  NPC: Barenngo
-- Involved with Quests: 'Dont Ever Leaf Me'
-- !pos -101 3 14 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local DELM = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.DONT_EVER_LEAF_ME)

    if DELM == xi.questStatus.QUEST_ACCEPTED and player:getCharVar('DELM_Barenngo_Branch') < 1 then
        -- Progresses Quest: 'Dont Ever Leaf Me'
        player:startEvent(5015)
    elseif DELM == xi.questStatus.QUEST_ACCEPTED and player:getCharVar('DELM_Barenngo_Branch') < 2 then
        -- Reminds player of hint for Quest: 'Dont Ever Leaf Me'
        player:startEvent(5016)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5015 then
        -- Progresses Quest: 'Dont Ever Leaf Me'
        player:setCharVar('DELM_Barenngo_Branch', 1)
    end
end

return entity
