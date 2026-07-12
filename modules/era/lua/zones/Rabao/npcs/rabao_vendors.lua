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
            { xi.item.SCROLL_OF_PROTECT_IV,    88400 },
            { xi.item.SCROLL_OF_PROTECTRA_IV,  84240 },
            { xi.item.SCROLL_OF_DISPEL,        72800 },
            { xi.item.SCROLL_OF_STUN,          36400 },
            { xi.item.SCROLL_OF_FLASH,         36400 },
            { xi.item.SCROLL_OF_RERAISE_III,  624000 },
            { xi.item.SCROLL_OF_BANISH_III,    89440 },
        }

        -- Add Cura, Sacrifice, Esuna, Auspice if WOTG is enabled
        if xi.module.isContentEnabled('WOTG') then
            table.insert(stock, { xi.item.SCROLL_OF_CURA,      22713 })
            table.insert(stock, { xi.item.SCROLL_OF_SACRIFICE, 70304 })
            table.insert(stock, { xi.item.SCROLL_OF_ESUNA,     73008 })
            table.insert(stock, { xi.item.SCROLL_OF_AUSPICE,   35006 })
        end

        player:showText(npc, zones[xi.zone.RABAO].text.BRAVEOX_SHOP_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
    end)

    -- Scamplix: Remove Rabao Waystone
    m:addOverride('xi.zones.Rabao.npcs.Scamplix.onTrigger', function(player, npc)
        local stock =
        {
            { xi.item.FLASK_OF_DISTILLED_WATER,     12 },
            { xi.item.STRIP_OF_MEAT_JERKY,         124 },
            { xi.item.LOAF_OF_GOBLIN_BREAD,        312 },
            { xi.item.CACTUS_ARM,                  832 },
            { xi.item.ETHER,                      5025 },
            { xi.item.THUNDERMELON,                338 },
            { xi.item.WATERMELON,                  208 },
            { xi.item.POTION,                      946 },
            { xi.item.ANTIDOTE,                    328 },
            { xi.item.FLASK_OF_BLINDNESS_POTION,  1248 },
            { xi.item.MYTHRIL_EARRING,            4680 },
            { xi.item.WATER_JUG,                   208 },
        }

        player:showText(npc, zones[xi.zone.RABAO].text.SCAMPLIX_SHOP_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
    end)
end

return m
