-----------------------------------
-- Module: Magic Adjustments (Seekers of Adoulin era)
-- Desc: Reverts adjustments to spells and their effects that were made during the SoA era
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('soa_magic_adjustments')

-- Gravity: Revert weight to apply an evasion down penalty
-- Source: https://forum.square-enix.com/ffxi/threads/43135-Jul-8-2014-(JST)-Version-Update
m:addOverride('xi.effects.weight.onEffectGain', function(target, effect)
    super(target, effect)

    effect:addMod(xi.mod.EVA, -10)
end)

return m
