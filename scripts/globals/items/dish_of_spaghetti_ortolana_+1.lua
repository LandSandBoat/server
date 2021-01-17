-----------------------------------------
-- ID: 5659
-- Item: Dish of Spafhetti Ortolana
-- Food Effect: 1 Hr, All Races
-----------------------------------------
-- Agility 2
-- Vitality 2
-- HP +30% Cap 75
-- StoreTP +6
-- Resist Blind +10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 7200, 5659)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.AGI, 2)
    target:addMod(tpz.mod.FOOD_HPP, 30)
    target:addMod(tpz.mod.FOOD_HP_CAP, 75)
    target:addMod(tpz.mod.STORETP, 6)
    target:addMod(tpz.mod.BLINDRES, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.AGI, 2)
    target:delMod(tpz.mod.FOOD_HPP, 30)
    target:delMod(tpz.mod.FOOD_HP_CAP, 75)
    target:delMod(tpz.mod.STORETP, 6)
    target:delMod(tpz.mod.BLINDRES, 10)
end

return item_object
