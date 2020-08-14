-----------------------------------------
-- ID: 18242
-- Item: Wyvern Feed
-- Item Effect: Pet Regen
-- Duration 3 Minutes
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    local pet = target:getPet()
    if not pet then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    elseif effect ~= nil and effect:getSubType() == 18242 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 18242)
end

function onEffectGain(target, effect)
    local pet = target:getPet()
    pet:addMod(tpz.mod.REGEN, 3)
end

function onEffectLose(target, effect)
    local pet = target:getPet()
    if pet ~= nil then
        pet:delMod(tpz.mod.REGEN, 3)
    end
end
