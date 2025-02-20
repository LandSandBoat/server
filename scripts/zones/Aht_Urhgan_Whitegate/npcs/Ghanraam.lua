-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ghanraam
-- Type: "Nyzul Weapon/Salvage Armor Storer, "
-- !pos 108.773 -6.999 -51.297 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(893)
end

return entity
