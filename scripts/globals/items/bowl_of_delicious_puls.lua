-----------------------------------
-- ID: 4533
-- Item: Bowl of Delicious Puls
-- Food Effect: 240Min, All Races
-----------------------------------
-- Dexterity -1
-- Vitality 3
-- Health Regen While Healing 5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4533)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, -1)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.HPHEAL, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, -1)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.HPHEAL, 5)
end

return item_object
