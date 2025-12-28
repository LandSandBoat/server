-----------------------------------
-- Area: Upper Jeuno
--  NPC: Coumuna
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.MYTHRIL_CLAWS,    29760 },
        { xi.item.KATARS,           15488 },
        { xi.item.MYTHRIL_KNIFE,    14560 },
        { xi.item.KRIS,             12096 },
        { xi.item.MYTHRIL_DEGEN,    31000 },
        { xi.item.KNIGHTS_SWORD,    85250 },
        { xi.item.TWO_HANDED_SWORD, 13926 },
        { xi.item.MYTHRIL_AXE,      48600 },
        { xi.item.GREATAXE,          4550 },
        { xi.item.MYTHRIL_ROD,       6256 },
        { xi.item.OAK_CUDGEL,       11232 },
        { xi.item.MYTHRIL_MACE,     18048 },
        { xi.item.WARHAMMER,         6558 },
        { xi.item.OAK_POLE,         37440 },
        { xi.item.HALBERD,          44550 },
        { xi.item.SCYTHE,           10596 },
        { xi.item.IRON_ARROW,           8 },
    }

    player:showText(npc, zones[xi.zone.UPPER_JEUNO].text.VIETTES_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
