-----------------------------------------
-- ID: 5320
-- Item: Chunk of Smelling Salts
-- Item Effect: Recover Pets from Sleep
-- Duration: 180 Secs Medicated
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    pet = target:getPet()
    if (pet == nil) then
        return tpz.msg.basic.REQUIRES_A_PET
    elseif (pet:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

function onItemUse(target)
    if (target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 180, 5320)) then
        target:messageBasic(GAINS_EFFECT_OF_STATUS, tpz.effect.MEDICINE)
        pet:delStatusEffect(tpz.effect.SLEEP_I)
        pet:delStatusEffect(tpz.effect.SLEEP_II)
        pet:delStatusEffect(tpz.effect.LULLABY)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

function onEffectGain(target, effect)
end

function onEffectLose(target, effect)
end
