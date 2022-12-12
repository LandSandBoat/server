-----------------------------------
-- ID: 5171
-- Item: emerald_quiche
-- Food Effect: 60Min, All Races
-----------------------------------
-- Magic 15
-- Agility 1
-- Ranged ACC % 7
-- Ranged ACC Cap 20
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5171)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 15)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.FOOD_RACCP, 7)
    target:addMod(xi.mod.FOOD_RACC_CAP, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 15)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.FOOD_RACCP, 7)
    target:delMod(xi.mod.FOOD_RACC_CAP, 20)
end

return itemObject
