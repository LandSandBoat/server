-----------------------------------
-- ID: 4600
-- Item: lucky_egg
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 14
-- Magic 14
-- Evasion 10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4600)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 14)
    target:addMod(xi.mod.MP, 14)
    target:addMod(xi.mod.EVA, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 14)
    target:delMod(xi.mod.MP, 14)
    target:delMod(xi.mod.EVA, 10)
end

return itemObject
