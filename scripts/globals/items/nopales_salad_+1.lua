-----------------------------------
-- ID: 5702
-- Item: Nopales Salad +1
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Strength 2
-- Agility 7
-- Ranged Accuracy +25
-- Ranged Attack +15
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5702)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 2)
    target:addMod(tpz.mod.AGI, 7)
    target:addMod(tpz.mod.RACC, 25)
    target:addMod(tpz.mod.RATT, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 2)
    target:delMod(tpz.mod.AGI, 7)
    target:delMod(tpz.mod.RACC, 25)
    target:delMod(tpz.mod.RATT, 15)
end

return item_object
