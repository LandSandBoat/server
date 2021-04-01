-----------------------------------
-- ID: 4355
-- Item: salmon_sub_sandwich
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 2
-- Agility 1
-- Vitality 1
-- Intelligence 2
-- Mind -2
-- Ranged ACC 2
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4355)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.INT, 2)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.RACC, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.INT, 2)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.RACC, 2)
end

return item_object
