-----------------------------------
-- Area: Heavens Tower
--  NPC: Rakano-Marukano
-- Type: Immigration NPC
-- !pos 6.174 -1 32.285 242
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.conquest.immigration.onTrigger(player, npc, xi.nation.WINDURST)
end

entity.onEventFinish = function(player, csid, option)
    xi.conquest.immigration.onEventFinish(player, csid, option, xi.nation.WINDURST)
end

return entity
