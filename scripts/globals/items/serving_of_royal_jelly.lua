-----------------------------------
-- ID: 4508
-- Item: Serving of Royal Jelly
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- MP Recovery while healing 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4508)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 3)
end

return itemObject
