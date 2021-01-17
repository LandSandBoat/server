-----------------------------------------
-- ID: 4601
-- Item: Bowl of Sopa de Pez Blanco
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Health 12
-- Dexterity 6
-- Mind -4
-- Accuracy 3
-- Ranged ACC % 7
-- Ranged ACC Cap 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4601)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 12)
    target:addMod(tpz.mod.DEX, 6)
    target:addMod(tpz.mod.MND, -4)
    target:addMod(tpz.mod.ACC, 3)
    target:addMod(tpz.mod.FOOD_RACCP, 7)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 12)
    target:delMod(tpz.mod.DEX, 6)
    target:delMod(tpz.mod.MND, -4)
    target:delMod(tpz.mod.ACC, 3)
    target:delMod(tpz.mod.FOOD_RACCP, 7)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 10)
end

return item_object
