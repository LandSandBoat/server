-----------------------------------
-- ID: 5686
-- Item: cheese_sandwich
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP 10
-- Agility 1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5686)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 10)
    target:addMod(xi.mod.AGI, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 10)
    target:delMod(xi.mod.AGI, 1)
end

return itemObject
