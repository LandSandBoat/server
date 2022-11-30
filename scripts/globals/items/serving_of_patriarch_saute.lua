-----------------------------------
-- ID: 5677
-- Item: Serving of Patriarch Sautee
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- MP 65
-- Mind 7
-- MP Recovered While Healing 7
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5677)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 65)
    target:addMod(xi.mod.MND, 7)
    target:addMod(xi.mod.MPHEAL, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 65)
    target:delMod(xi.mod.MND, 7)
    target:delMod(xi.mod.MPHEAL, 7)
end

return itemObject
