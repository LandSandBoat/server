-----------------------------------
-- Area: Al Zahbi
--  NPC: Chochoroon
-- Type: Appraiser
-- !pos -42.739 -1 -45.987 48
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.appraisal.appraiseItem(player, npc, trade, 50, 261)
end

entity.onTrigger = function(player, npc)
    player:startEvent(260, 50)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.appraisal.appraisalOnEventFinish(player, csid, option, 50, 261, npc)
end

return entity
