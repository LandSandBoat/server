-----------------------------------
-- Area: Rabao
--  NPC: Brave Wolf
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BUCKLER,           35658 },
        { xi.item.DARKSTEEL_BUCKLER, 68868 },
        { xi.item.SILVER_BANGLES,    27855 },
        { xi.item.BANDED_MAIL,       75504 },
        { xi.item.MUFFLERS,          40326 },
        { xi.item.BREECHES,          60060 },
        { xi.item.SOLLERETS,         36894 },
        { xi.item.BLACK_TUNIC,       10770 },
        { xi.item.WHITE_MITTS,        5023 },
        { xi.item.BLACK_SLACKS,       7176 },
        { xi.item.SANDALS,            4667 },
        { xi.item.PADDED_ARMOR,      32747 },
        { xi.item.IRON_MITTENS,      17971 },
        { xi.item.IRON_SUBLIGAR,     26357 },
        { xi.item.LEGGINGS,          16373 },
    }

    player:showText(npc, zones[xi.zone.RABAO].text.BRAVEWOLF_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
