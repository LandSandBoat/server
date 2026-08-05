-----------------------------------
-- Area: Rabao
--  NPC: Brave Wolf
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BUCKLER,           34287 },
        { xi.item.DARKSTEEL_BUCKLER, 66220 },
        { xi.item.SILVER_BANGLES,    26784 },
        { xi.item.BANDED_MAIL,       72600 },
        { xi.item.MUFFLERS,          38775 },
        { xi.item.BREECHES,          57750 },
        { xi.item.SOLLERETS,         35475 },
        { xi.item.BLACK_TUNIC,       10356 },
        { xi.item.WHITE_MITTS,        4830 },
        { xi.item.BLACK_SLACKS,       6900 },
        { xi.item.SANDALS,            4488 },
        { xi.item.PADDED_ARMOR,      31488 },
        { xi.item.IRON_MITTENS,      17280 },
        { xi.item.IRON_SUBLIGAR,     25344 },
        { xi.item.LEGGINGS,          15744 },
    }

    player:showText(npc, zones[xi.zone.RABAO].text.BRAVEWOLF_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
end

return entity
