-----------------------------------
-- ID: 5727
-- Item: serving_of_zaru_soba
-- Food Effect: 30Min?, All Races
-----------------------------------
-- Agility 3
-- HP % 12 (cap 180)
-- Resist Sleep +5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5727)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 3)
    target:addMod(xi.mod.FOOD_HPP, 12)
    target:addMod(xi.mod.FOOD_HP_CAP, 180)
    target:addMod(xi.mod.SLEEPRES, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 3)
    target:delMod(xi.mod.FOOD_HPP, 12)
    target:delMod(xi.mod.FOOD_HP_CAP, 180)
    target:delMod(xi.mod.SLEEPRES, 5)
end

return itemObject
