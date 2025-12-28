-----------------------------------
-- ID: 5131
-- Item: Vongola Clam
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Dexterity -5
-- Vitality 4
-- Defense +17% - 50 Cap
-- HP 5% - 50 Cap
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_FISH)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, -5)
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.FOOD_DEFP, 17)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 50)
    effect:addMod(xi.mod.FOOD_HPP, 5)
    effect:addMod(xi.mod.FOOD_HP_CAP, 50)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
