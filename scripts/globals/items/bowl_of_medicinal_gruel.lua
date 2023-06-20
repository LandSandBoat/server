-----------------------------------
-- ID: 4534
-- Item: bowl_of_medicinal_gruel
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- Vitality -1
-- Agility 2
-- Ranged Accuracy % 15 (cap 15)
-- HP Recovered While Healing 4
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4534)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.FOOD_RACCP, 15)
    target:addMod(xi.mod.FOOD_RACC_CAP, 15)
    target:addMod(xi.mod.HPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.FOOD_RACCP, 15)
    target:delMod(xi.mod.FOOD_RACC_CAP, 15)
    target:delMod(xi.mod.HPHEAL, 4)
end

return itemObject
