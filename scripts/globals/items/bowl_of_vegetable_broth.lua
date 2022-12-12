-----------------------------------
-- ID: 4323
-- Item: bowl_of_vegetable_broth
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- Vitality -1
-- Agility 5
-- Ranged Accuracy 6
-- HP Recovered While Healing 3
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4323)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.AGI, 5)
    target:addMod(xi.mod.RACC, 6)
    target:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.AGI, 5)
    target:delMod(xi.mod.RACC, 6)
    target:delMod(xi.mod.HPHEAL, 3)
end

return itemObject
