-----------------------------------
-- ID: 5633
-- Item: Chocolate Cake
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- MP +3% (cap 90)
-- HP Recovered while healing +1
-- MP Recovered while healing +6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5633)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 3)
    target:addMod(tpz.mod.FOOD_MP_CAP, 90)
    target:addMod(tpz.mod.HPHEAL, 1)
    target:addMod(tpz.mod.MPHEAL, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 3)
    target:delMod(tpz.mod.FOOD_MP_CAP, 90)
    target:delMod(tpz.mod.HPHEAL, 1)
    target:delMod(tpz.mod.MPHEAL, 6)
end

return item_object
