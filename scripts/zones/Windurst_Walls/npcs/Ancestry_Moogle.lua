-----------------------------------
-- Area: Windurst Walls
--  NPC: Ancestry Moogle
-- Type: Race Change NPC
-- !pos -220 1 -108 239
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
