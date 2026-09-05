-----------------------------------
-- Namonutice: Fame checker
-- Event 31 has hard coded fame values so pass the value based on rank
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('southern_san_doria_fame_check')

m:addOverrideByEra('xi.zones.Southern_San_dOria.npcs.Namonutice.onTrigger', {
    [xi.expansion.ROV] = function(player, npc)
        player:startEvent(31, xi.data.fame.fameConversionPoints[player:getFameLevel(xi.fameArea.SANDORIA)])
    end,
})
