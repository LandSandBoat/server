-----------------------------------
-- Area: Port San d'Oria
--  NPC: Festive Moogle
-- Type: Event NPC
--  !pos 70.641 -16.000 -118.589 232
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.festiveMoogle.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.festiveMoogle.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.festiveMoogle.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.festiveMoogle.onEventFinish(player, csid, option, npc)
end

return entity
