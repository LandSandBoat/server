-----------------------------------
-- Area: Selbina
--  NPC: Torapiont
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CLAWS,            12768 },
        { xi.item.MYTHRIL_DAGGER,    8586 },
        { xi.item.TUCK,             12876 },
        { xi.item.MYTHRIL_CLAYMORE, 42000 },
        { xi.item.BATTLEAXE,        12267 },
        { xi.item.GREATAXE,          4550 },
        { xi.item.WILLOW_WAND,        370 },
        { xi.item.YEW_WAND,          1566 },
        { xi.item.HOLLY_STAFF,        635 },
        { xi.item.DART,                10 },
        { xi.item.CROSSBOW_BOLT,        6 },
        { xi.item.WOODEN_ARROW,         4 },
        { xi.item.IRON_ARROW,           8 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.TORAPIONT_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
end

return entity
