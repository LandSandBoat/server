-----------------------------------
-- Area: Lower Jeuno
--  NPC: Greyson
-- A.M.A.N. Trove
-- !pos -92.000 -0.255 -165.500 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.amanTrove.onGreysonTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.amanTrove.onGreysonTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.amanTrove.onGreysonEventFinish(player, csid, option, npc)
end

return entity
