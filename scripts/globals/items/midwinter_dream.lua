-----------------------------------
-- ID: 5543
-- Item: midwinter_dream
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP 10
-- MP 8% Cap 60
-- Intelligence 2
-- HP Recovered while healing 2
-- MP Recovered while healing 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5543)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.FOOD_MPP, 8)
    target:addMod(tpz.mod.FOOD_MP_CAP, 60)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.FOOD_MPP, 8)
    target:delMod(tpz.mod.FOOD_MP_CAP, 60)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 2)
end

return item_object
