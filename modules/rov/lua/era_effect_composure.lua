-----------------------------------
-- Era Composure effect
-- Removes extra effects added to Composure in RoV
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/55025-February.-8-2019-%28JST%29-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_effect_composure')

m:addOverride('xi.effects.composure.onEffectGain', function(target, effect)
    local power = math.floor(target:getMainLvl() / 5)

    effect:addMod(xi.mod.ACC, power)
end)

return m
