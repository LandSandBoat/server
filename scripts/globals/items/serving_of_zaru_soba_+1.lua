-----------------------------------
-- ID: 5728
-- Item: serving_of_zaru_soba_+1
-- Food Effect: 60min, All Races
-----------------------------------
-- Agility 4
-- HP % 12 (cap 185)
-- Resist Sleep +10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5728)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.FOOD_HPP, 12)
    target:addMod(xi.mod.FOOD_HP_CAP, 185)
    target:addMod(xi.mod.SLEEPRES, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.FOOD_HPP, 12)
    target:delMod(xi.mod.FOOD_HP_CAP, 185)
    target:delMod(xi.mod.SLEEPRES, 10)
end

return itemObject
