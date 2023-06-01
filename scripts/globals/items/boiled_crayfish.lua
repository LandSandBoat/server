-----------------------------------
-- ID: 4535
-- Item: Boiled Crayfish
-- Food Effect: 30Min, All Races
-----------------------------------
-- defense % 30
-- defense % 25
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4535)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_DEFP, 30)
    target:addMod(xi.mod.FOOD_DEF_CAP, 25)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_DEFP, 30)
    target:delMod(xi.mod.FOOD_DEF_CAP, 25)
end

return itemObject
