-----------------------------------------
-- ID: 4355
-- Item: salmon_sub_sandwich
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Dexterity 2
-- Agility 1
-- Vitality 1
-- Intelligence 2
-- Mind -2
-- Ranged ACC 2
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4355)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.RACC, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.RACC, 2)
end

return item_object
