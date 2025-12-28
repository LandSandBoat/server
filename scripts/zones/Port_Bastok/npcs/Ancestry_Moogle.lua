-----------------------------------
-- Area: Port Bastok
--  NPC: Ancestry Moogle
-- Type: Race Change NPC
-- !pos 116.080 7.372 -31.820 236
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
