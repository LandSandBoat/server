-----------------------------------
-- ID: 5983
-- Item: Piscator's Skewer
-- Food Effect: 60 Mins, All Races
-----------------------------------
-- Dexterity 3
-- Vitality 4
-- Defense % 26 Cap 155
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5983)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.FOOD_DEFP, 26)
    target:addMod(xi.mod.FOOD_DEF_CAP, 155)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.FOOD_DEFP, 26)
    target:delMod(xi.mod.FOOD_DEF_CAP, 155)
end

return itemObject
