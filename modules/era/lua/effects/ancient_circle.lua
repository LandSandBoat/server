-----------------------------------
-- ToAU Era Ancient Circle
-- Removes the damage dealt/taken modifiers added in the July 21, 2009 version update
-----------------------------------
-- Source: https://wiki.ffo.jp/html/22242.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_effect_ancient_circle', xi.pre(xi.expansion.WOTG))

m:addOverride('xi.effects.ancient_circle.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.DRAGON_KILLER, effect:getPower())
end)
