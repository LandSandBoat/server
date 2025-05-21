-----------------------------------
-- Area: Windurst Woods
--  NPC: Peshi Yohnts
-- Type: Bonecraft Guild Master
-- !pos -6.175 -6.249 -144.667 241
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
