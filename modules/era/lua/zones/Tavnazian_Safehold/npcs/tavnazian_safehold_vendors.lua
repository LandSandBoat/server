-----------------------------------
-- Tavnazian Safehold Vendor Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'tavnazian_safehold_vendors_adjust'
local m = Module:new(moduleName)

if not xi.module.isContentEnabled('SOA') then
    -- Nilerouche: Removes OOE spell scrolls from stock
    m:addOverride('xi.zones.Tavnazian_Safehold.npcs.Nilerouche.onTrigger', function(player, npc)
        local stock = {}

        if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.SHELTERING_DOUBT then
            stock =
            {
                { xi.item.LUFAISE_FLY,              108 },
                { xi.item.CLOTHESPOLE,             2640 },
                { xi.item.ARROWWOOD_LOG,             20 },
                { xi.item.ELM_LOG,                 7800 },
                { xi.item.SCROLL_OF_BANISH_III,   66000 },
            }
        else
            stock =
            {
                { xi.item.LUFAISE_FLY,              108 },
                { xi.item.CLOTHESPOLE,             2640 },
                { xi.item.ARROWWOOD_LOG,             20 },
                { xi.item.ELM_LOG,                 7800 },
            }
        end

        player:showText(npc, zones[xi.zone.TAVNAZIAN_SAFEHOLD].text.NILEROUCHE_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)

    -- Mazuro-Oozuro: Remove Safehold Waystone from stock
    m:addOverride('xi.zones.Tavnazian_Safehold.npcs.Mazuro-Oozuro.onTrigger', function(player, npc)
        local stock = {}

        if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.SHELTERING_DOUBT then
            stock =
            {
                { xi.item.LUFAISE_FLY,              108 },
                { xi.item.CLOTHESPOLE,             2640 },
                { xi.item.ARROWWOOD_LOG,             20 },
                { xi.item.ELM_LOG,                 7800 },
                { xi.item.SCROLL_OF_BANISH_III,   66000 },
            }
        else
            stock =
            {
                { xi.item.LUFAISE_FLY,              108 },
                { xi.item.CLOTHESPOLE,             2640 },
                { xi.item.ARROWWOOD_LOG,             20 },
                { xi.item.ELM_LOG,                 7800 },
            }
        end

        player:showText(npc, zones[xi.zone.TAVNAZIAN_SAFEHOLD].text.MAZUROOOZURO_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end)
end

return m
