-----------------------------------------
-- ID: 5616
-- Item: lebkuchen_house
-- Food Effect: 180Min, All Races
-----------------------------------------
-- HP +8
-- MP +10% (cap 45)
-- INT +3
-- hHP +2
-- hMP +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5616)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 8)
    target:addMod(tpz.mod.FOOD_MPP, 10)
    target:addMod(tpz.mod.FOOD_MP_CAP, 45)
    target:addMod(tpz.mod.INT, 3)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 8)
    target:delMod(tpz.mod.FOOD_MPP, 10)
    target:delMod(tpz.mod.FOOD_MP_CAP, 45)
    target:delMod(tpz.mod.INT, 3)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 1)
end

return item_object
