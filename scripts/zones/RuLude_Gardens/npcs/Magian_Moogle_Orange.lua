-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Orange Bobble)
-- Type: Magian Trials NPC (Weapons)
-- !pos -11 2.453 118 64
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.magian.magianOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.magian.magianOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.magian.magianEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.magian.magianOnEventFinish(player, csid, option, npc)
end

return entity
