-----------------------------------
-- ID: 5678
-- Item: Mushroom Salad
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- MP 14% Cap 85
-- Agility 6
-- Mind 6
-- Strength -5
-- Vitality -5
-- Ranged Accuracy +15
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(xi.effect.FOOD)) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5678)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 14)
    target:addMod(xi.mod.FOOD_MP_CAP, 85)
    target:addMod(xi.mod.AGI, 6)
    target:addMod(xi.mod.MND, 6)
    target:addMod(xi.mod.STR, -5)
    target:addMod(xi.mod.VIT, -5)
    target:addMod(xi.mod.RACC, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 14)
    target:delMod(xi.mod.FOOD_MP_CAP, 85)
    target:delMod(xi.mod.AGI, 6)
    target:delMod(xi.mod.MND, 6)
    target:delMod(xi.mod.STR, -5)
    target:delMod(xi.mod.VIT, -5)
    target:delMod(xi.mod.RACC, 15)
end

return item_object
