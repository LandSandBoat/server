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
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6224)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 25)
    target:addMod(tpz.mod.FOOD_MP_CAP, 105)
    target:addMod(tpz.mod.INT, 6)
    target:addMod(tpz.mod.MND, 6)
    target:addMod(tpz.mod.MATT, 14)
    target:addMod(tpz.mod.LIZARD_KILLER, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 25)
    target:delMod(tpz.mod.FOOD_MP_CAP, 105)
    target:delMod(tpz.mod.INT, 6)
    target:delMod(tpz.mod.MND, 6)
    target:delMod(tpz.mod.MATT, 14)
    target:delMod(tpz.mod.LIZARD_KILLER, 6)
end

return item_object
