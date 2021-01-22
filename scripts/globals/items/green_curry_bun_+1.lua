-----------------------------------
-- ID: 5762
-- Item: green_curry_bun_+1
-- Food Effect: 60 min, All Races
-----------------------------------
-- TODO: Group effects
-- VIT +3
-- AGI +4
-- Ranged Accuracy +10% (cap 25)
-- DEF +13% (cap 180)
-- Resist Sleep +5
-- hHP +6
-- hMP +3
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5762)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.FOOD_RACCP, 10)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 25)
    target:addMod(tpz.mod.FOOD_DEFP, 13)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 180)
    target:addMod(tpz.mod.SLEEPRES, 5)
    target:addMod(tpz.mod.HPHEAL, 6)
    target:addMod(tpz.mod.MPHEAL, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.FOOD_RACCP, 10)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 25)
    target:delMod(tpz.mod.FOOD_DEFP, 13)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 180)
    target:delMod(tpz.mod.SLEEPRES, 5)
    target:delMod(tpz.mod.HPHEAL, 6)
    target:delMod(tpz.mod.MPHEAL, 3)
end

return item_object
