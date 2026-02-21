-----------------------------------
-- ID: 5982
-- Item: Senroh Skewer
-- Food Effect: 30 Mins, All Races
-----------------------------------
-- Dexterity 2
-- Vitality 3
-- Mind -1
-- Defense % 25 Cap 150
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 1800, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, 2)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.MND, -1)
    effect:addMod(xi.mod.FOOD_DEFP, 25)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 150)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
