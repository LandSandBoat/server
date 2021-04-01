-----------------------------------
-- xi.effect.AUSPICE
-- Power: Used for Enspell Effect
-- SubPower: Tracks Subtle Blow Bonus
-- Tier: Used for Enspell Calculation
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    --Auspice Reduces TP via adding to your Subtle Blow Mod
    local subtleBlowBonus = 10 + target:getMod(xi.mod.AUSPICE_EFFECT)
    --printf("AUSPICE: Adding Subtle Blow +%d!", subtleBlowBonus)
    effect:setSubPower(subtleBlowBonus)
    target:addMod(xi.mod.SUBTLE_BLOW, subtleBlowBonus)

    --Afflatus Misery Bonuses
    if (target:hasStatusEffect(xi.effect.AFFLATUS_MISERY)) then
        target:getStatusEffect(xi.effect.AFFLATUS_MISERY):setSubPower(0)
        target:addMod(xi.mod.ENSPELL, 18)
        target:addMod(xi.mod.ENSPELL_DMG, effect:getPower())
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local subtleBlow = effect:getSubPower()
    --printf("AUSPICE: Removing Subtle Blow +%d!", subtleBlow)
    target:delMod(xi.mod.SUBTLE_BLOW, subtleBlow)

    --Clean Up Any Bonuses That From Afflatus Misery Combo
    if (target:hasStatusEffect(xi.effect.AFFLATUS_MISERY)) then
        local accuracyBonus = target:getStatusEffect(xi.effect.AFFLATUS_MISERY):getSubPower()
        --printf("AUSPICE: Removing Accuracy Bonus +%d!", accuracyBonus)
        target:delMod(xi.mod.ACC, accuracyBonus)
        local accuracyBonus = target:getStatusEffect(xi.effect.AFFLATUS_MISERY):setSubPower(0)

        target:setMod(xi.mod.ENSPELL_DMG, 0)
        target:setMod(xi.mod.ENSPELL, 0)
    end

end

return effect_object
