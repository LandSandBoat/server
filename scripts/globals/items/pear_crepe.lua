-----------------------------------
-- ID: 5777
-- Item: Pear Crepe
-- Food Effect: 30 Min, All Races
-----------------------------------
-- Intelligence +2
-- MP Healing +2
-- Magic Accuracy +20% (cap 45)
-- Magic Defense +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5777)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.FOOD_MACCP, 20)
    target:addMod(tpz.mod.FOOD_MACC_CAP, 45)
    target:addMod(tpz.mod.MDEF, 1)
    target:addMod(tpz.mod.MPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.FOOD_MACCP, 20)
    target:delMod(tpz.mod.FOOD_MACC_CAP, 45)
    target:delMod(tpz.mod.MDEF, 1)
    target:delMod(tpz.mod.MPHEAL, 2)
end

return item_object
