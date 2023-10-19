-----------------------------------
-- Pre-RMT Countermeasure Drops
-----------------------------------
require('modules/module_utils')
require('scripts/globals/treasure')
-----------------------------------
local m = Module:new('pre_rmt_drops')

m:addOverride('xi.zones.Castle_Oztroja.Zone.onInitialize', function(zone)
    xi.treasure.treasureInfo[xi.treasure.type.COFFER].zone[xi.zone.CASTLE_OZTROJA].item = { 0.150, xi.item.ASTRAL_RING }
end)

return m
