-----------------------------------------
-- ID: 5220
-- Item: plate_of_ikra_gunkan_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 30
-- Magic 12
-- Dexterity 3
-- Mind -1
-- Accuracy % 18
-- Accuracy Cap 30
-- Ranged ACC % 18
-- Ranged ACC Cap 30
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5220)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.MP, 12)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.FOOD_ACCP, 18)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 30)
    target:addMod(tpz.mod.FOOD_RACCP, 18)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 30)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.MP, 12)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.FOOD_ACCP, 18)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 30)
    target:delMod(tpz.mod.FOOD_RACCP, 18)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 30)
end

return item_object
