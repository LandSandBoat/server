-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Faulpie
-- Type: Leathercraft Guild Master
-- !pos -178.882 -2 9.891 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildMasterOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildMasterOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.crafting.guildMasterOnEventFinish(player, csid, option, npc)
end

return entity
