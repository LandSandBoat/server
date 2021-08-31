-----------------------------------
-- ID: 5220
-- Item: plate_of_ikra_gunkan_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 30
-- Magic 12
-- Dexterity 3
-- Mind -1
-- Accuracy % 18
-- Accuracy Cap 30
-- Ranged ACC % 18
-- Ranged ACC Cap 30
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5220)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.MP, 12)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.FOOD_ACCP, 18)
    target:addMod(xi.mod.FOOD_ACC_CAP, 30)
    target:addMod(xi.mod.FOOD_RACCP, 18)
    target:addMod(xi.mod.FOOD_RACC_CAP, 30)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.MP, 12)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.FOOD_ACCP, 18)
    target:delMod(xi.mod.FOOD_ACC_CAP, 30)
    target:delMod(xi.mod.FOOD_RACCP, 18)
    target:delMod(xi.mod.FOOD_RACC_CAP, 30)
end

return item_object
