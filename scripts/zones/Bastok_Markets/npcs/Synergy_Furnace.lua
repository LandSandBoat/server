-----------------------------------
-- Area: Bastok Markets
--  NPC: Synergy Furnace
-- !pos -186.801 2.000 -146.603 235
-- !pos -193.959 2.000 -149.429 235
-- !pos -269.000 -12.500 -31.000 235
-- !pos -263.000 -12.500 -31.000 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.synergy.synergyFurnaceOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.synergy.synergyFurnaceOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.synergy.synergyFurnaceOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.synergy.synergyFurnaceOnEventFinish(player, csid, option, npc)
end

return entity
