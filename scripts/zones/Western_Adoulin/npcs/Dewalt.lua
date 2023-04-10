-----------------------------------
-- Area: Western Adoulin
--  NPC: Dewalt
-- Involved with Quests: 'Flavors of our Lives', 'Dont Ever Leaf Me'
--  !pos -23 0 28 256
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local DELM = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.DONT_EVER_LEAF_ME)

    if DELM == QUEST_ACCEPTED and player:getCharVar("DELM_Dewalt_Branch") < 1 then
        -- Progresses Quest: 'Dont Ever Leaf Me'
        player:startEvent(5013)
    elseif DELM == QUEST_ACCEPTED and player:getCharVar("DELM_Dewalt_Branch") < 2 then
        -- Reminds player of hint for Quest: 'Dont Ever Leaf Me'
        player:startEvent(5014)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 5013 then
        -- Progresses Quest: 'Dont Ever Leaf Me'
        player:setCharVar("DELM_Dewalt_Branch", 1)
    end
end

return entity
