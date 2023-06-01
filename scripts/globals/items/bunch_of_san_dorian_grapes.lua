-----------------------------------
-- ID: 4431
-- Item: Bunch of San Dorian Grapes
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility -5
-- Intelligence 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4431)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, -5)
    target:addMod(xi.mod.INT, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, -5)
    target:delMod(xi.mod.INT, 3)
end

return itemObject
