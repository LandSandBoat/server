-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Beriphaule
-- Type: Allegiance Changer NPC
-- !pos -247.422 7.000 28.992 231
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.conquest.immigration.onTrigger(player, npc, xi.nation.SANDORIA)
end

entity.onEventFinish = function(player, csid, option)
    xi.conquest.immigration.onEventFinish(player, csid, option, xi.nation.SANDORIA)
end

return entity
