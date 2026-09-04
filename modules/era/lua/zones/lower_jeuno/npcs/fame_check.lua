-----------------------------------
-- Mendi: Fame checker
-- Event 82 has hard coded fame values so pass the value based on rank
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('lower_jeuno_fame_check')

m:addOverrideByEra('xi.zones.Lower_Jeuno.npcs.Mendi.onTrigger', {
    [xi.expansion.ROV] = function(player, npc)
        player:startEvent(82, xi.data.fame.fameConversionPoints[player:getFameLevel(xi.fameArea.JEUNO)])
    end,
})
