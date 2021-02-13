-----------------------------------
-- tpz.effect.AFFLATUS_MISERY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:setMod(tpz.mod.AFFLATUS_MISERY, 0)

    if (target:hasStatusEffect(tpz.effect.AUSPICE)) then
        local power = target:getStatusEffect(tpz.effect.AUSPICE):getPower()
        target:addMod(tpz.mod.ENSPELL, 18)
        target:addMod(tpz.mod.ENSPELL_DMG, power)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setMod(tpz.mod.AFFLATUS_MISERY, 0)

    --Clean Up Afflatus Misery Bonuses
    local accuracyBonus = effect:getSubPower()
    --printf("AUSPICE: Removing Accuracy Bonus +%d!", accuracyBonus)
    target:delMod(tpz.mod.ACC, accuracyBonus)

    if (target:hasStatusEffect(tpz.effect.AUSPICE)) then
        target:setMod(tpz.mod.ENSPELL, 0)
        target:setMod(tpz.mod.ENSPELL_DMG, 0)
    end
end

return effect_object
