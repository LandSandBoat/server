-----------------------------------------
-- ID: 5658
-- Item: Dish of Spafhetti Ortolana
-- Food Effect: 30 Mins, All Races
-----------------------------------------
-- Agility 2
-- Vitality 2
-- HP +30% Cap 70
-- StoreTP +6
-- Resist Blind +10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5658)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.AGI, 2)
    target:addMod(tpz.mod.FOOD_HPP, 30)
    target:addMod(tpz.mod.FOOD_HP_CAP, 70)
    target:addMod(tpz.mod.STORETP, 6)
    target:addMod(tpz.mod.BLINDRES, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.AGI, 2)
    target:delMod(tpz.mod.FOOD_HPP, 30)
    target:delMod(tpz.mod.FOOD_HP_CAP, 70)
    target:delMod(tpz.mod.STORETP, 6)
    target:delMod(tpz.mod.BLINDRES, 10)
end
