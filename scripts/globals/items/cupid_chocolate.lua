-----------------------------------
-- ID: 5681
-- Item: cupid_chocolate
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Accuracy +10
-- Ranged Accuracy +10
-- Attack 10
-- Ranged Attack 10
-- Store TP +25
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5681)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ATT, 10)
    target:addMod(xi.mod.RATT, 10)
    target:addMod(xi.mod.ACC, 10)
    target:addMod(xi.mod.RACC, 10)
    target:addMod(xi.mod.STORETP, 25)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATT, 10)
    target:delMod(xi.mod.RATT, 10)
    target:delMod(xi.mod.ACC, 10)
    target:delMod(xi.mod.RACC, 10)
    target:delMod(xi.mod.STORETP, 25)
end

return itemObject
