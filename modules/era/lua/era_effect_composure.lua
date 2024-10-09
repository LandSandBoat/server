-----------------------------------
-- Era Composure effect
-- Pre 8 Feb 2019
-- https://forum-square--enix-com.translate.goog/ffxi/threads/55024?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_effect_composure')

m:addOverride('xi.effects.composure.onEffectGain', function(target, effect)
    local power = math.floor(target:getMainLvl() / 5)

    effect:addMod(xi.mod.ACC, power)
end)

return m
