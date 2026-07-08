-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ancestry Moogle
-- Type: Race Change NPC
-- !pos 73.7 -124 -16 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    return xi.ancestryMoogle.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    return xi.ancestryMoogle.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    return xi.ancestryMoogle.onEventFinish(player, csid, option, npc)
end

return entity
