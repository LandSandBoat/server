-----------------------------------
-- Area: Western Adoulin
--  NPC: Preterig
-- Type: Shop NPC
-- !pos 6 0 -53 256
-----------------------------------
local ID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Standard shop
    player:showText(npc, ID.text.PRETERIG_SHOP_TEXT)
    local stock =
    {
        4423, 300,    -- Apple Juice
        5944, 125,    -- Frontier Soda
        4421, 1560,   -- Melon Pie
        4422, 200,    -- Orange Juice
    }
    xi.shop.general(player, stock)
end

return entity
