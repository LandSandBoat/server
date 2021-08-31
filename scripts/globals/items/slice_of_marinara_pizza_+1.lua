-----------------------------------
-- ID: 6212
-- Item: slice of marinara pizza +1
-- Food Effect: 60 minutes, all Races
-----------------------------------
-- HP +25
-- Accuracy+11% (Max. 58)
-- Attack+21% (Max. 55)
-- "Undead Killer"+5
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6212)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 25)
    target:addMod(xi.mod.FOOD_ACCP, 11)
    target:addMod(xi.mod.FOOD_ACC_CAP, 58)
    target:addMod(xi.mod.FOOD_ATTP, 21)
    target:addMod(xi.mod.FOOD_ATT_CAP, 55)
    target:addMod(xi.mod.UNDEAD_KILLER, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 25)
    target:delMod(xi.mod.FOOD_ACCP, 11)
    target:delMod(xi.mod.FOOD_ACC_CAP, 58)
    target:delMod(xi.mod.FOOD_ATTP, 21)
    target:delMod(xi.mod.FOOD_ATT_CAP, 55)
    target:delMod(xi.mod.UNDEAD_KILLER, 5)
end

return item_object
