-----------------------------------
-- ID: 4453
-- Item: Bowl of Eyeball Soup
-- Food Effect: 180Min, All Races
-----------------------------------
-- HP +6% (cap 70)
-- Charisma -10
-- Health Regen While Healing 4
-- Accuracy 12
-- Ranged ACC 12
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4453)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 6)
    target:addMod(tpz.mod.FOOD_HP_CAP, 70)
    target:addMod(tpz.mod.CHR, -10)
    target:addMod(tpz.mod.HPHEAL, 4)
    target:addMod(tpz.mod.ACC, 12)
    target:addMod(tpz.mod.RACC, 12)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 6)
    target:delMod(tpz.mod.FOOD_HP_CAP, 70)
    target:delMod(tpz.mod.CHR, -10)
    target:delMod(tpz.mod.HPHEAL, 4)
    target:delMod(tpz.mod.ACC, 12)
    target:delMod(tpz.mod.RACC, 12)
end

return item_object
