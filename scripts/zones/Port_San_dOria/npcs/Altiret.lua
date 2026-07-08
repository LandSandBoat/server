-----------------------------------
-- Area: Port San d'Oria
--  NPC: Altiret
-- NPC for Quest "The Pickpocket"
-- !pos 21.263 -3.999 -65.776 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    player:startEvent(551)
end

return entity
