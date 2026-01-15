-----------------------------------
-- Hit Rate Cap Override Module
-- Reverts all melee hit caps to 95% to undo hit cap raise in December 2014.
--
-- Source: https://forum.square-enix.com/ffxi/threads/45365?p=534537#post534537
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('physical_hit_rate')

m:addOverride('xi.combat.physicalHitRate.getPhysicalHitRateCap', function(attacker, slot)
    return 0.95
end)

return m
