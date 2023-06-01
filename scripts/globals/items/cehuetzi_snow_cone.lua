-----------------------------------
-- ID: 6223
-- Item: Cehuetzi snow cone
-- Food Effect: 30 Min, All Races
-----------------------------------
-- MP +20% (cap 100)
-- INT +5
-- MND +5
-- Magic Atk. Bonus +13
-- Lizard Killer +5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6223)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 20)
    target:addMod(xi.mod.FOOD_MP_CAP, 100)
    target:addMod(xi.mod.INT, 5)
    target:addMod(xi.mod.MND, 5)
    target:addMod(xi.mod.MATT, 13)
    target:addMod(xi.mod.LIZARD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 20)
    target:delMod(xi.mod.FOOD_MP_CAP, 100)
    target:delMod(xi.mod.INT, 5)
    target:delMod(xi.mod.MND, 5)
    target:delMod(xi.mod.MATT, 13)
    target:delMod(xi.mod.LIZARD_KILLER, 5)
end

return itemObject
