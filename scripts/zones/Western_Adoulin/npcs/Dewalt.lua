-----------------------------------
-- Area: Western Adoulin
--  NPC: Dewalt
-- Involved with Quests: 'Flavors of our Lives', 'Dont Ever Leaf Me'
--  !pos -23 0 28 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local DELM = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.DONT_EVER_LEAF_ME)

    if DELM == xi.questStatus.QUEST_ACCEPTED and player:getCharVar('DELM_Dewalt_Branch') < 1 then
        -- Progresses Quest: 'Dont Ever Leaf Me'
        player:startEvent(5013)
    elseif DELM == xi.questStatus.QUEST_ACCEPTED and player:getCharVar('DELM_Dewalt_Branch') < 2 then
        -- Reminds player of hint for Quest: 'Dont Ever Leaf Me'
        player:startEvent(5014)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5013 then
        -- Progresses Quest: 'Dont Ever Leaf Me'
        player:setCharVar('DELM_Dewalt_Branch', 1)
    end
end

return entity
