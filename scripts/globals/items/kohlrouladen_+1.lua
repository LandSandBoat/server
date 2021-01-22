-----------------------------------
-- ID: 5761
-- Item: kohlrouladen
-- Food Effect: 4hr, All Races
-----------------------------------
-- Strength 4
-- Agility 4
-- Intelligence -4
-- RACC +10% (cap 65)
-- RATT +16% (cap 70)
-- Enmity -5
-- Subtle Blow +6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5761)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 4)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.INT, -4)
    target:addMod(tpz.mod.FOOD_RACCP, 10)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 65)
    target:addMod(tpz.mod.FOOD_RATTP, 16)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 70)
    target:addMod(tpz.mod.ENMITY, -5)
    target:addMod(tpz.mod.SUBTLE_BLOW, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 4)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.INT, -4)
    target:delMod(tpz.mod.FOOD_RACCP, 10)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 65)
    target:delMod(tpz.mod.FOOD_RATTP, 16)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 70)
    target:delMod(tpz.mod.ENMITY, -5)
    target:delMod(tpz.mod.SUBTLE_BLOW, 6)
end

return item_object
