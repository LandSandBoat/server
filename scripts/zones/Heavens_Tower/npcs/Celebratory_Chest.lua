-----------------------------------
-- Area: Heavens Tower
--  NPC: Celebratory Chest
-- Type: Merchant NPC
-- !pos -7.600 0.249 25.239 242
-----------------------------------
local ID = zones[xi.zone.HEAVENS_TOWER]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageText(npc, ID.text.CELEBRATORY_GOODS, false, 6)
    xi.shop.celebratory(player)
end

return entity
