-----------------------------------
-- ID: 5739
-- Item: mug_of_honeyed_egg
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP 8
-- Intelligence 1
-- MP recovered while healing 1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5739)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 8)
    target:addMod(xi.mod.INT, 1)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 8)
    target:delMod(xi.mod.INT, 1)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
