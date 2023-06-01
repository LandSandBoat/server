-----------------------------------
-- ID: 5766
-- Item: Butter Crepe
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +10% (cap 10)
-- Magic Accuracy +20% (cap 25)
-- Magic Defense +1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5766)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 10)
    target:addMod(xi.mod.MDEF, 1)
    target:addMod(xi.mod.FOOD_MACCP, 20)
    target:addMod(xi.mod.FOOD_MACC_CAP, 25)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 10)
    target:delMod(xi.mod.MDEF, 1)
    target:delMod(xi.mod.FOOD_MACCP, 20)
    target:delMod(xi.mod.FOOD_MACC_CAP, 25)
end

return itemObject
