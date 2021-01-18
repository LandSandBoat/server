-----------------------------------
-- ID: 5744
-- Item: marinara_pizza +1
-- Food Effect: 4 hours, all Races
-----------------------------------
-- HP +25
-- Attack +21% (cap 55)
-- Accuracy +11% (cap 58)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5744)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 25)
    target:addMod(tpz.mod.FOOD_ATTP, 21)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 55)
    target:addMod(tpz.mod.FOOD_ACCP, 11)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 58)
    target:addMod(tpz.mod.UNDEAD_KILLER, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 25)
    target:delMod(tpz.mod.FOOD_ATTP, 21)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 55)
    target:delMod(tpz.mod.FOOD_ACCP, 11)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 58)
    target:delMod(tpz.mod.UNDEAD_KILLER, 5)
end

return item_object
