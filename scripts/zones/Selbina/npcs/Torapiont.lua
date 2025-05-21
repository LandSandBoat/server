-----------------------------------
-- Area: Selbina
--  NPC: Torapiont
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.CLAWS,            13278 },
        { xi.item.MYTHRIL_DAGGER,    8929 },
        { xi.item.TUCK,             13391 },
        { xi.item.MYTHRIL_CLAYMORE, 43680 },
        { xi.item.BATTLEAXE,        12757 },
        { xi.item.GREATAXE,          4732 },
        { xi.item.WILLOW_WAND,        384 },
        { xi.item.YEW_WAND,          1628 },
        { xi.item.HOLLY_STAFF,        660 },
        { xi.item.DART,                10 },
        { xi.item.CROSSBOW_BOLT,        6 },
        { xi.item.WOODEN_ARROW,         4 },
        { xi.item.IRON_ARROW,           8 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.TORAPIONT_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
