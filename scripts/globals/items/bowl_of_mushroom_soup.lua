-----------------------------------
-- ID: 4419
-- Item: mushroom_soup
-- Food Effect: 3hours, All Races
-----------------------------------
-- Magic Points 20
-- Strength -1
-- Mind 2
-- MP Recovered While Healing 1
-- Enmity -2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4419)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 20)
    target:addMod(xi.mod.STR, -1)
    target:addMod(xi.mod.MND, 2)
    target:addMod(xi.mod.MPHEAL, 1)
    target:addMod(xi.mod.ENMITY, -2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 20)
    target:delMod(xi.mod.STR, -1)
    target:delMod(xi.mod.MND, 2)
    target:delMod(xi.mod.MPHEAL, 1)
    target:delMod(xi.mod.ENMITY, -2)
end

return itemObject
