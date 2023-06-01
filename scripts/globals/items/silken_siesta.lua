-----------------------------------
-- ID: 5626
-- Item: Silken Siesta
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP Recoverd while healing 2
-- MP Recovered while healing 5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5626)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 5)
end

return itemObject
