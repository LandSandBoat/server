-----------------------------------
--  NPC: Bro Moogle
-----------------------------------
require("scripts/globals/era_npc")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.eraNpc.broMoogleTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.eraNpc.broMoogleTrigger(player, npc)
end

return entity
