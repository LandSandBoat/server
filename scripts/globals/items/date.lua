-----------------------------------
-- ID: 5566
-- Item: Date
-- Food Effect: 5 Mins, All Races
-----------------------------------
-- Intelligence 1
-- Agility -3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5566)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 1)
    target:addMod(xi.mod.AGI, -3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 1)
    target:delMod(xi.mod.AGI, -3)
end

return itemObject
