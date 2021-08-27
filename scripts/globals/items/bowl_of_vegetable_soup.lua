-----------------------------------
-- ID: 4560
-- Item: bowl_of_vegetable_soup
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Vitality -1
-- Agility 4
-- Ranged Accuracy 5
-- HP Recovered While Healing 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4560)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.RACC, 5)
    target:addMod(xi.mod.HPHEAL, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.RACC, 5)
    target:delMod(xi.mod.HPHEAL, 3)
end

return item_object
