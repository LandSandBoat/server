-----------------------------------
-- ID: 5643
-- Item: serving_of_cibarious_cilbir
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP % 6 (cap 150)
-- MP % 6 (cap 100)
-- HP recovered while healing 3
-- MP recovered while healing 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5643)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 6)
    target:addMod(tpz.mod.FOOD_HP_CAP, 150)
    target:addMod(tpz.mod.FOOD_MPP, 6)
    target:addMod(tpz.mod.FOOD_MP_CAP, 100)
    target:addMod(tpz.mod.MPHEAL, 4)
    target:addMod(tpz.mod.HPHEAL, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 6)
    target:delMod(tpz.mod.FOOD_HP_CAP, 150)
    target:delMod(tpz.mod.FOOD_MPP, 6)
    target:delMod(tpz.mod.FOOD_MP_CAP, 100)
    target:delMod(tpz.mod.MPHEAL, 4)
    target:delMod(tpz.mod.HPHEAL, 3)
end

return item_object
