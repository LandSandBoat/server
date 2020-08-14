-----------------------------------------
-- ID: 5678
-- Item: Mushroom Salad
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- MP 14% Cap 85
-- Agility 6
-- Mind 6
-- Strength -5
-- Vitality -5
-- Ranged Accuracy +15
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5678)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 14)
    target:addMod(tpz.mod.FOOD_MP_CAP, 85)
    target:addMod(tpz.mod.AGI, 6)
    target:addMod(tpz.mod.MND, 6)
    target:addMod(tpz.mod.STR, -5)
    target:addMod(tpz.mod.VIT, -5)
    target:addMod(tpz.mod.RACC, 15)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 14)
    target:delMod(tpz.mod.FOOD_MP_CAP, 85)
    target:delMod(tpz.mod.AGI, 6)
    target:delMod(tpz.mod.MND, 6)
    target:delMod(tpz.mod.STR, -5)
    target:delMod(tpz.mod.VIT, -5)
    target:delMod(tpz.mod.RACC, 15)
end
