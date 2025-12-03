-----------------------------------
-- ID: 6460
-- Item: bowl_of_miso_ramen
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +100
-- STR +5
-- VIT +5
-- DEF +10% (cap 170)
-- Magic Evasion +10% (cap 50)
-- Magic Def. Bonus +5
-- Resist Slow +10
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 100)
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.VIT, 5)
    effect:addMod(xi.mod.FOOD_DEFP, 10)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 170)
    -- effect:addMod(xi.mod.FOOD_MEVAP, 10)
    -- effect:addMod(xi.mod.FOOD_MEVA_CAP, 50)
    effect:addMod(xi.mod.MDEF, 5)
    effect:addMod(xi.mod.SLOWRES, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
