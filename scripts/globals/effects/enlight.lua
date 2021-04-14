-----------------------------------
-- xi.effect.ENLIGHT
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.ENLIGHT_EFFECT)

    target:addMod(xi.mod.ENSPELL, xi.magic.element.LIGHT)
    target:addMod(xi.mod.ENSPELL_DMG, effect:getPower() + jpValue)
    target:addMod(xi.mod.ACC, jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.ENLIGHT_EFFECT)

    target:setMod(xi.mod.ENSPELL_DMG, 0)
    target:setMod(xi.mod.ENSPELL, 0)
    target:delMod(xi.mod.ACC, jpValue)
end

return effect_object
