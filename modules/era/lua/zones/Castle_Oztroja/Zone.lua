-----------------------------------
-- Pre-RMT Countermeasure Drops
-- Returns Astral Ring to Castle Oztroja chest drops
-----------------------------------
-- Source: http://www.playonline.com/updateus/041209we8yu0.html
-----------------------------------
require('modules/module_utils')
require('scripts/globals/treasure')
-----------------------------------
-- NOTE: When re-enabling the override below, capture the module again:
-- local m = Module:new('pre_rmt_drops')
Module:new('pre_rmt_drops')

if xi.module.isContentEnabled('COP') then
    return
end

--[[
-- This Module is disabled until the new treasure system is tested an appropiate amount of time.
m:addOverride('xi.zones.Castle_Oztroja.Zone.onInitialize', function(zone)
    xi.treasure.lootTable[xi.zone.CASTLE_OZTROJA][2] =
    {
        { xi.item.NONE,        690 }, -- Gil
        { xi.item.ASTRAL_RING, 150 }, -- Item
        { xi.item.AQUAMARINE,   20 },
        { xi.item.CHRYSOBERYL,  20 },
        { xi.item.FLUORITE,     20 },
        { xi.item.JADEITE,      20 },
        { xi.item.MOONSTONE,    20 },
        { xi.item.PAINITE,      20 },
        { xi.item.SUNSTONE,     20 },
        { xi.item.ZIRCON,       20 },
    },

end)
]]--
