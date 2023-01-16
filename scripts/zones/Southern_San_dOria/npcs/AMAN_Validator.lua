-----------------------------------
-- Area: Southern San d'Oria
-- NPC: A.M.A.N Validator
-- !pos -83.07 1 -55.58 230
-----------------------------------
require('scripts/globals/deeds')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.deeds.validatorOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.deeds.validatorOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.deeds.validatorOnEventFinish(player, csid, option, npc)
end

return entity
