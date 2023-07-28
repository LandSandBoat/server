-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ghanraam
-- Type: "Nyzul Weapon/Salvage Armor Storer, "
-- !pos 108.773 -6.999 -51.297 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(893)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
