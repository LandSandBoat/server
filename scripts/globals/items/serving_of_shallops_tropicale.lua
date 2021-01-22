-----------------------------------
-- ID: 4554
-- Item: serving_of_shallops_tropicale
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic 20
-- Dexterity 1
-- Vitality 4
-- Intelligence 1
-- Defense % 25
-- Defense Cap 100
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4554)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MP, 20)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 100)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MP, 20)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 100)
end

return item_object
