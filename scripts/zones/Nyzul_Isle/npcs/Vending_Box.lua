-----------------------------------
-- Area:  Nyzul_Isle
-- NPC:   Vending Box
-- Notes: Pick Temp items for assault
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.nyzul.vendingBoxOnTrigger(player)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.nyzul.vendingBoxOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
