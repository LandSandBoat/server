-----------------------------------
-- ID: 5778
-- Item: Crepe Belle Helene
-- Food Effect: 60 Min, All Races
-----------------------------------
-- Intelligence +2
-- MP Healing +3
-- Magic Accuracy +21% (cap 50)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5778)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 2)
    target:addMod(xi.mod.MPHEAL, 3)
    target:addMod(xi.mod.FOOD_MACCP, 21)
    target:addMod(xi.mod.FOOD_MACC_CAP, 50)
    target:addMod(xi.mod.MDEF, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 2)
    target:delMod(xi.mod.MPHEAL, 3)
    target:delMod(xi.mod.FOOD_MACCP, 21)
    target:delMod(xi.mod.FOOD_MACC_CAP, 50)
    target:delMod(xi.mod.MDEF, 1)
end

return itemObject
