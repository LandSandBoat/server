-----------------------------------
-- Area: Fort Karugo-Narugo
--  NPC: Spondulix
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.HI_POTION,                   4500 },
        { xi.item.HI_ETHER,                   28000 },
        { xi.item.LUMP_OF_KARUGO_NARUGO_CLAY,  3035 },
    }

    player:showText(npc, zones[xi.zone.FORT_KARUGO_NARUGO_S].text.SPONDULIX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
