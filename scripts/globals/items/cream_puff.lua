-----------------------------------
-- ID: 5718
-- Item: Cream Puff
-- Food Effect: 30 mintutes, All Races
-----------------------------------
-- Intelligence +7
-- HP -10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5718)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 7)
    target:addMod(xi.mod.HP, -10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 7)
    target:delMod(xi.mod.HP, -10)
end

return itemObject
