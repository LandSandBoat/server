-----------------------------------
-- Rabao Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'rabao_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('ABYSSEA') then
    -- Brave Ox: Remove post-era scrolls (Cure VI, Protect V, Shell V, Crusade)
    m:addOverride('xi.zones.Rabao.npcs.Brave_Ox.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.SCROLL_OF_PROTECT_IV,    85000 },
            { xi.item.SCROLL_OF_PROTECTRA_IV,  81000 },
            { xi.item.SCROLL_OF_DISPEL,        70000 },
            { xi.item.SCROLL_OF_STUN,          35000 },
            { xi.item.SCROLL_OF_FLASH,         35000 },
            { xi.item.SCROLL_OF_RERAISE_III,  600000 },
            { xi.item.SCROLL_OF_BANISH_III,    86000 },
        }

        -- Add Cura, Sacrifice, Esuna, Auspice if WOTG is enabled
        if xi.module.isContentEnabled('WOTG') then
            table.insert(stock, { xi.item.SCROLL_OF_CURA,      21840 })
            table.insert(stock, { xi.item.SCROLL_OF_SACRIFICE, 67600 })
            table.insert(stock, { xi.item.SCROLL_OF_ESUNA,     70200 })
            table.insert(stock, { xi.item.SCROLL_OF_AUSPICE,   33660 })
        end

        player:showText(npc, zones[xi.zone.RABAO].text.BRAVEOX_SHOP_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
    end)

    -- Scamplix: Remove Rabao Waystone
    m:addOverride('xi.zones.Rabao.npcs.Scamplix.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.FLASK_OF_DISTILLED_WATER,     12 },
            { xi.item.STRIP_OF_MEAT_JERKY,         120 },
            { xi.item.LOAF_OF_GOBLIN_BREAD,        300 },
            { xi.item.CACTUS_ARM,                  800 },
            { xi.item.ETHER,                      4832 },
            { xi.item.THUNDERMELON,                325 },
            { xi.item.WATERMELON,                  200 },
            { xi.item.POTION,                      910 },
            { xi.item.ANTIDOTE,                    316 },
            { xi.item.FLASK_OF_BLINDNESS_POTION,  1200 },
            { xi.item.MYTHRIL_EARRING,            4500 },
            { xi.item.WATER_JUG,                   200 },
        }

        player:showText(npc, zones[xi.zone.RABAO].text.SCAMPLIX_SHOP_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
    end)

    -- Generoit: Rework broth prices for in era values
    m:addOverride('xi.zones.Rabao.npcs.Generoit.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.BUNCH_OF_GYSAHL_GREENS,       67 },
            { xi.item.CHOCOBO_FEATHER,               8 },
            { xi.item.PET_FOOD_ALPHA_BISCUIT,       12 },
            { xi.item.PET_FOOD_BETA_BISCUIT,        89 },
            { xi.item.JUG_OF_CARROT_BROTH,          90 },
            { xi.item.JUG_OF_BUG_BROTH,            756 },
            { xi.item.JUG_OF_HERBAL_BROTH,         138 },
            { xi.item.JUG_OF_CARRION_BROTH,        756 },
            { xi.item.SCROLL_OF_CHOCOBO_MAZURKA, 55200 },
        }

        player:showText(npc, zones[xi.zone.RABAO].text.GENEROIT_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)
end

return m
