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
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5702)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.AGI, 7)
    target:addMod(xi.mod.RACC, 25)
    target:addMod(xi.mod.RATT, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.AGI, 7)
    target:delMod(xi.mod.RACC, 25)
    target:delMod(xi.mod.RATT, 15)
end

return item_object
