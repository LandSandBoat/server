-----------------------------------
-- Gekko Shop Adjustments
-- Remove Regen IV scroll from stock
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'gekko_shop_adjust'

if xi.module.isContentEnabled('WOTG') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.zones.Port_Jeuno.npcs.Gekko.onTrigger', function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_EYE_DROPS,                2595 },
        { xi.item.ANTIDOTE,                           316 },
        { xi.item.FLASK_OF_ECHO_DROPS,                800 },
        { xi.item.POTION,                             910 },
        { xi.item.ETHER,                             4832 },
        { xi.item.ROLANBERRY,                         120 },
        { xi.item.COPY_OF_AUTUMNS_END_IN_GUSTABERG, 36000 },
        { xi.item.COPY_OF_ACOLYTES_GRIEF,           31224 },
    }

    player:showText(npc, zones[xi.zone.PORT_JEUNO].text.DUTY_FREE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end)

return m
