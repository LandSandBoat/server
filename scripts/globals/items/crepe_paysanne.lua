-----------------------------------
-- ID: 5772
-- Item: crepe_paysanne
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +10% (cap 30)
-- STR +2
-- VIT +1
-- Magic Accuracy +15
-- Magic Defense +4
-- hHP +3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5772)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 30)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.MACC, 15)
    target:addMod(xi.mod.MDEF, 4)
    target:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 30)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.MACC, 15)
    target:delMod(xi.mod.MDEF, 4)
    target:delMod(xi.mod.HPHEAL, 3)
end

return itemObject
