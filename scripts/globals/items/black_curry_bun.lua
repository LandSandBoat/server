-----------------------------------------
-- ID: 5758
-- Item: black_curry_bun
-- Food Effect: 30minutes, All Races
-----------------------------------------
-- TODO: Group effects
-- DEX +2
-- VIT +4
-- INT +1
-- Accuracy +5
-- Ranged Accuracy +5
-- Evasion +5
-- DEF +15% (cap 180)
-- Resist Sleep +3
-- hHP +2
-- hMP +1
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5758)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.ACC, 5)
    target:addMod(tpz.mod.RACC, 5)
    target:addMod(tpz.mod.EVA, 5)
    target:addMod(tpz.mod.FOOD_DEFP, 15)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 180)
    target:addMod(tpz.mod.SLEEPRES, 3)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.ACC, 5)
    target:delMod(tpz.mod.RACC, 5)
    target:delMod(tpz.mod.EVA, 5)
    target:delMod(tpz.mod.FOOD_DEFP, 15)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 180)
    target:delMod(tpz.mod.SLEEPRES, 3)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 1)
end

return item_object
