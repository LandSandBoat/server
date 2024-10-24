-----------------------------------
-- Area: Balgas Dais
--  NPC: Terminal Coffer
-- BCNM: A.M.A.N. Trove (Mars)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.amanTrove.terminalCofferOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
