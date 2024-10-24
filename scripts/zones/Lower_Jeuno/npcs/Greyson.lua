-----------------------------------
-- Area: Lower Jeuno
--  NPC: Greyson
-- A.M.A.N. Trove NPC
-- !pos -92.000 -0.255 -165.500 245
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.amanTrove.onGreysonTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.amanTrove.onGreysonTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.amanTrove.onGreysonEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.amanTrove.onGreysonEventFinish(player, csid, option, npc)
end

return entity
