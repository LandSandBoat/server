-----------------------------------
-- Area: Metalworks
--  NPC: Mythily
-- Type: Immigration NPC
-- !pos 94 -20 -8 237
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.conquest.immigration.onTrigger(player, npc, xi.nation.BASTOK)
end

entity.onEventFinish = function(player, csid, option)
    xi.conquest.immigration.onEventFinish(player, csid, option, xi.nation.BASTOK)
end

return entity
