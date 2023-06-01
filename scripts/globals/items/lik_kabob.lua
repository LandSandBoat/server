-----------------------------------
-- ID: 5647
-- Item: Lik Kabob
-- Food Effect: 30 Min, All Races
-----------------------------------
-- Dexterity 3
-- Mind -2
-- Accuracy +1
-- Attack 7
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5647)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.ACC, 1)
    target:addMod(xi.mod.ATT, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.ACC, 1)
    target:delMod(xi.mod.ATT, 7)
end

return itemObject
