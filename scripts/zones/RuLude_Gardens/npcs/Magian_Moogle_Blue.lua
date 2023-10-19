-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Blue Bobble)
-- Type: Magian Trials NPC (Armor)
-- !pos -6.843 2.459 121.9 64
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
