-----------------------------------
-- ID: 4498
-- Item: cup_of_chocomilk
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic Regen While Healing 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4498)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 3)
end

return itemObject
