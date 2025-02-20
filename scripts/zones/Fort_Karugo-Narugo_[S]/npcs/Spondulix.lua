-----------------------------------
-- Area: Fort Karugo-Narugo
--  NPC: Spondulix
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4116,  4500,    -- Hi-Potion
        4132, 28000,    -- Hi-Ether
        2563,  3035,    -- Karugo Clay
    }

    player:showText(npc, ID.text.SPONDULIX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
