-----------------------------------
-- ID: 4285
-- Item: bowl_of_ocean_soup
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP +5% (cap 150)
-- MP +5
-- DEX +4
-- Attack +14% (cap 90)
-- Ranged Attack +14% (cap 90)
-- HP recovered while healing +9
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4285)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 5)
    target:addMod(xi.mod.FOOD_HP_CAP, 150)
    target:addMod(xi.mod.MP, 5)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.HPHEAL, 9)
    target:addMod(xi.mod.FOOD_ATTP, 14)
    target:addMod(xi.mod.FOOD_ATT_CAP, 90)
    target:addMod(xi.mod.FOOD_RATTP, 14)
    target:addMod(xi.mod.FOOD_RATT_CAP, 90)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 5)
    target:delMod(xi.mod.FOOD_HP_CAP, 150)
    target:delMod(xi.mod.MP, 5)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.HPHEAL, 9)
    target:delMod(xi.mod.FOOD_ATTP, 14)
    target:delMod(xi.mod.FOOD_ATT_CAP, 90)
    target:delMod(xi.mod.FOOD_RATTP, 14)
    target:delMod(xi.mod.FOOD_RATT_CAP, 90)
end

return itemObject
