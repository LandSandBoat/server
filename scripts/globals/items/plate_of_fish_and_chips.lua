-----------------------------------
-- ID: 5145
-- Item: plate_of_fish_and_chips
-- Food Effect: 180Min, All Races
-----------------------------------
-- Dexterity 3
-- Vitality 3
-- Mind -3
-- defense 5
-- Ranged ATT % 7
-- Ranged ATT Cap 10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5145)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.DEF, 5)
    target:addMod(xi.mod.FOOD_RATTP, 7)
    target:addMod(xi.mod.FOOD_RATT_CAP, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.DEF, 5)
    target:delMod(xi.mod.FOOD_RATTP, 7)
    target:delMod(xi.mod.FOOD_RATT_CAP, 10)
end

return itemObject
