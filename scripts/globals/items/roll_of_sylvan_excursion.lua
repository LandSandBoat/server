-----------------------------------
-- ID: 5551
-- Item: Roll of Sylvan Excursion
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10
-- MP +3% Cap 15
-- Intelligence +3
-- HP Recovered while healing +2
-- MP Recovered while healing +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5551)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 3)
    target:addMod(tpz.mod.FOOD_MP_CAP, 15)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.INT, 3)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 3)
    target:delMod(tpz.mod.FOOD_MP_CAP, 15)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.INT, 3)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 5)
end

return item_object
