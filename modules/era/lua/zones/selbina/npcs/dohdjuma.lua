-----------------------------------
-- Dohdjuma: Remove Selbina Waystone
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('dohdjuma_adjust', xi.pre(xi.expansion.ABYSSEA))

-- TODO: find a patch note or source for this change
m:addOverride('xi.zones.Selbina.npcs.Dohdjuma.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.BAG_OF_RYE_FLOUR,            40 },
        { xi.item.SCROLL_OF_SHEEPFOE_MAMBO,   259 },
        { xi.item.FLASK_OF_EYE_DROPS,        2595 },
        { xi.item.ANTIDOTE,                   316 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12 },
        { xi.item.POTION,                     910 },
        { xi.item.LUGWORM,                     12 },
        { xi.item.JUG_OF_SELBINA_MILK,         61 },
        { xi.item.PICKLED_HERRING,            480 },
        { xi.item.SERVING_OF_HERB_QUUS,      4984 },
    }

    player:showText(npc, zones[xi.zone.SELBINA].text.DOHDJUMA_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
end)
