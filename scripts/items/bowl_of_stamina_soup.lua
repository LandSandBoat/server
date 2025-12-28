-----------------------------------
-- ID: 4337
-- Item: bowl_of_stamina_soup
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP +12% (cap 200)
-- Dexterity 4
-- Vitality 6
-- Mind -3
-- HP Recovered While Healing 10
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HPP, 12)
    effect:addMod(xi.mod.FOOD_HP_CAP, 200)
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.VIT, 6)
    effect:addMod(xi.mod.MND, -3)
    effect:addMod(xi.mod.HPHEAL, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
