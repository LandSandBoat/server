-----------------------------------
-- ID: 5588
-- Item: serving_of_karni_yarik
-- Food Effect: 30Min, All Races
-----------------------------------
-- Agility 3
-- Vitality -1
-- Attack % 20 (cap 65)
-- Ranged Attack % 20 (cap 65)
-- Evasion +6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5588)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 65)
    target:addMod(tpz.mod.FOOD_RATTP, 20)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 65)
    target:addMod(tpz.mod.EVA, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 65)
    target:delMod(tpz.mod.FOOD_RATTP, 20)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 65)
    target:delMod(tpz.mod.EVA, 6)
end

return item_object
