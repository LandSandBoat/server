-----------------------------------
-- Dohdjuma: Remove Selbina Waystone
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'dohdjuma_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ABYSSEA') then
    m:addOverride('xi.zones.Selbina.npcs.Dohdjuma.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BAG_OF_RYE_FLOUR,            41 },
            { xi.item.SCROLL_OF_SHEEPFOE_MAMBO,   269 },
            { xi.item.FLASK_OF_EYE_DROPS,        2698 },
            { xi.item.ANTIDOTE,                   328 },
            { xi.item.FLASK_OF_DISTILLED_WATER,    12 },
            { xi.item.POTION,                     946 },
            { xi.item.LUGWORM,                     12 },
            { xi.item.JUG_OF_SELBINA_MILK,         62 },
            { xi.item.PICKLED_HERRING,            499 },
            { xi.item.SERVING_OF_HERB_QUUS,      5183 },
        }

        player:showText(npc, zones[xi.zone.SELBINA].text.DOHDJUMA_SHOP_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
    end)
end

return m
