-----------------------------------
-- ID: 6461
-- Item: bowl_of_miso_ramen_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +105
-- STR +6
-- VIT +6
-- DEF +11% (cap 175)
-- Magic Evasion +11% (cap 55)
-- Magic Def. Bonus +6
-- Resist Slow +15
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 105)
    effect:addMod(xi.mod.STR, 6)
    effect:addMod(xi.mod.VIT, 6)
    effect:addMod(xi.mod.FOOD_DEFP, 11)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 175)
    -- effect:addMod(xi.mod.FOOD_MEVAP, 11)
    -- effect:addMod(xi.mod.FOOD_MEVA_CAP, 55)
    effect:addMod(xi.mod.MDEF, 6)
    effect:addMod(xi.mod.SLOWRES, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
