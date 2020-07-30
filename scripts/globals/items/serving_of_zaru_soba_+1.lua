-----------------------------------------
-- ID: 5728
-- Item: serving_of_zaru_soba_+1
-- Food Effect: 60min, All Races
-----------------------------------------
-- Agility 4
-- HP % 12 (cap 185)
-- Resist Sleep +10
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5728)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.FOOD_HPP, 12)
    target:addMod(tpz.mod.FOOD_HP_CAP, 185)
    target:addMod(tpz.mod.SLEEPRES, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.FOOD_HPP, 12)
    target:delMod(tpz.mod.FOOD_HP_CAP, 185)
    target:delMod(tpz.mod.SLEEPRES, 10)
end
