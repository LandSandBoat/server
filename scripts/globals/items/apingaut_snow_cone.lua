-----------------------------------
-- ID: 6224
-- Item: Apingaut snow cone
-- Food Effect: 30 Min, All Races
-----------------------------------
-- MP +25% (cap 105)
-- INT +6
-- MND +6
-- Magic Atk. Bonus +14
-- Lizard Killer +6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6224)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 25)
    target:addMod(xi.mod.FOOD_MP_CAP, 105)
    target:addMod(xi.mod.INT, 6)
    target:addMod(xi.mod.MND, 6)
    target:addMod(xi.mod.MATT, 14)
    target:addMod(xi.mod.LIZARD_KILLER, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 25)
    target:delMod(xi.mod.FOOD_MP_CAP, 105)
    target:delMod(xi.mod.INT, 6)
    target:delMod(xi.mod.MND, 6)
    target:delMod(xi.mod.MATT, 14)
    target:delMod(xi.mod.LIZARD_KILLER, 6)
end

return itemObject
