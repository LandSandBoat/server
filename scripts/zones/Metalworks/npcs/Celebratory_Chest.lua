-----------------------------------
-- Area: Metalworks
--  NPC: Celebratory Chest
-- Type: Merchant NPC
-- !pos 88.029 -20.170 -11.086 237
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.celebratory(player)
    player:messageSpecial(zones[xi.zone.METALWORKS].text.CELEBRATORY_GOODS)
end

return entity
