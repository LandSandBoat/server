-----------------------------------
-- ID: 5320
-- Item: Chunk of Smelling Salts
-- Item Effect: Recover Pets from Sleep
-- Duration: 180 Secs Medicated
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local pet = target:getPet()
    if pet == nil then
        return xi.msg.basic.REQUIRES_A_PET
    elseif pet:hasStatusEffect(xi.effect.MEDICINE) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:addStatusEffect(xi.effect.MEDICINE, 0, 0, 180, 5320) then
        local pet = target:getPet()
        -- TODO: Verify targeting and messages are correct
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.MEDICINE)
        pet:delStatusEffect(xi.effect.SLEEP_I)
        pet:delStatusEffect(xi.effect.SLEEP_II)
        pet:delStatusEffect(xi.effect.LULLABY)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

itemObject.onEffectGain = function(target, effect)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
