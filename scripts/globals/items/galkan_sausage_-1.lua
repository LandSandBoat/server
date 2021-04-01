-----------------------------------
-- ID: 5862
-- Item: galkan_sausage_-1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength -3
-- Dexterity -3
-- Vitality -3
-- Agility -3
-- Mind -3
-- Intelligence -3
-- Charisma -3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5862)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, -3)
    target:addMod(xi.mod.DEX, -3)
    target:addMod(xi.mod.VIT, -3)
    target:addMod(xi.mod.AGI, -3)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.CHR, -3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, -3)
    target:delMod(xi.mod.DEX, -3)
    target:delMod(xi.mod.VIT, -3)
    target:delMod(xi.mod.AGI, -3)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.CHR, -3)
end

return item_object
