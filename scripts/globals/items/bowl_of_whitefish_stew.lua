-----------------------------------
-- ID: 4440
-- Item: Bowl of Whitefish Stew
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 10
-- Dexterity 3
-- Mind -3
-- Accuracy 3
-- Ranged ACC % 7
-- Ranged ACC Cap 10
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4440)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 10)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.ACC, 3)
    target:addMod(xi.mod.FOOD_RACCP, 7)
    target:addMod(xi.mod.FOOD_RACC_CAP, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 10)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.ACC, 3)
    target:delMod(xi.mod.FOOD_RACCP, 7)
    target:delMod(xi.mod.FOOD_RACC_CAP, 10)
end

return item_object
