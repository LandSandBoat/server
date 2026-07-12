-----------------------------------
-- Valeriano Shop Adjustments
-- Remove OOE stock. Shared across Port_Bastok, Southern_San_dOria, and Windurst_Woods
-----------------------------------
require('modules/module_utils')
require('scripts/globals/shop')
-----------------------------------
local moduleName = 'valeriano_shop_adjust'

if xi.module.isContentEnabled('WOTG') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.shop.handleValerianoShop', function(player, npc)
    local zoneTable =
    {
        [xi.zone.SOUTHERN_SAN_DORIA] = { xi.nation.SANDORIA, xi.fameArea.SANDORIA },
        [xi.zone.PORT_BASTOK       ] = { xi.nation.BASTOK,   xi.fameArea.BASTOK   },
        [xi.zone.WINDURST_WOODS    ] = { xi.nation.WINDURST, xi.fameArea.WINDURST },
    }

    local stock =
    {
        { xi.item.GINGER_COOKIE,                 12 },
        { xi.item.FLUTE,                         49 },
        { xi.item.PICCOLO,                     1144 },
        { xi.item.SCROLL_OF_SCOPS_OPERETTA,     677 },
        { xi.item.SCROLL_OF_PUPPETS_OPERETTA, 19552 },
        { xi.item.SCROLL_OF_FOWL_AUBADE,       3369 },
        { xi.item.SCROLL_OF_ADVANCING_MARCH,   2379 },
        { xi.item.SCROLL_OF_GODDESSS_HYMNUS, 104000 },
    }

    local zoneId = player:getZoneID()

    -- Fail-safe in case npc didnt despawn.
    if GetNationRank(zoneTable[zoneId][1]) ~= 1 then
        return
    end

    -- Build shop.
    player:showText(npc, zones[zoneId].text.VALERIANO_SHOP_DIALOG)
    xi.shop.general(player, stock, zoneTable[zoneId][2])
end)

return m
