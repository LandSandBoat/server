-----------------------------------
-- ID: 4492
-- Item: bowl_of_puls
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Vitality 2
-- Dexterity -1
-- HP Recovered While Healing 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4492)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.DEX, -1)
    target:addMod(xi.mod.HPHEAL, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.DEX, -1)
    target:delMod(xi.mod.HPHEAL, 3)
end

return item_object
