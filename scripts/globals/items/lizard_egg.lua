-----------------------------------
-- ID: 4362
-- Item: lizard_egg
-- Food Effect: 5Min, All Races
-----------------------------------
-- Health 5
-- Magic 5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4362)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 5)
    target:addMod(xi.mod.MP, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 5)
    target:delMod(xi.mod.MP, 5)
end

return itemObject
