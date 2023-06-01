-----------------------------------
-- ID: 5659
-- Item: Dish of Spafhetti Ortolana
-- Food Effect: 1 Hr, All Races
-----------------------------------
-- Agility 2
-- Vitality 2
-- HP +30% Cap 75
-- StoreTP +6
-- Resist Blind +10
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 7200, 5659)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.FOOD_HPP, 30)
    target:addMod(xi.mod.FOOD_HP_CAP, 75)
    target:addMod(xi.mod.STORETP, 6)
    target:addMod(xi.mod.BLINDRES, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.FOOD_HPP, 30)
    target:delMod(xi.mod.FOOD_HP_CAP, 75)
    target:delMod(xi.mod.STORETP, 6)
    target:delMod(xi.mod.BLINDRES, 10)
end

return itemObject
