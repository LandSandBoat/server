-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ambleon
-- Type: NPC World Pass Dealer
-- !pos 71.622 -17 -137.134 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.worldPass.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.worldPass.onEventFinish(player, csid, option, npc)
end

return entity
