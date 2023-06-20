-----------------------------------
-- ID: 4410
-- Item: roast_mushroom
-- Food Effect: 30minutes, All Races
-----------------------------------
-- Magic Points 10
-- Strength -1
-- Mind 3
-- Enmity -1
-- MP Recovered While Healing 2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4410)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 10)
    target:addMod(xi.mod.STR, -1)
    target:addMod(xi.mod.MND, 3)
    target:addMod(xi.mod.ENMITY, -1)
    target:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 10)
    target:delMod(xi.mod.STR, -1)
    target:delMod(xi.mod.MND, 3)
    target:delMod(xi.mod.ENMITY, -1)
    target:delMod(xi.mod.MPHEAL, 2)
end

return itemObject
