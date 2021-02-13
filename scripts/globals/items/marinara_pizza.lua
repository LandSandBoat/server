-----------------------------------
-- ID: 5743
-- Item: marinara_pizza
-- Food Effect: 3 hours, all Races
-----------------------------------
-- HP +20
-- Attack +20% (cap 50 @ 250 base attack)
-- Accuracy +10% (54)
-- Undead Killer
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5743)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 50)
    target:addMod(tpz.mod.FOOD_ACCP, 10)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 54)
    target:addMod(tpz.mod.UNDEAD_KILLER, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 50)
    target:delMod(tpz.mod.FOOD_ACCP, 10)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 54)
    target:delMod(tpz.mod.UNDEAD_KILLER, 5)
end

return item_object
