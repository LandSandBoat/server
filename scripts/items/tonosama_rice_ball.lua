-----------------------------------
-- ID: 4277
-- Item: Tonosama Rice Ball
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +15
-- Dex +3
-- Vit +3
-- Chr +3
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Atk +50
-- Def +30
-- Double Attack +1%
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
    effect:addMod(xi.mod.FOOD_HP, 15)
    effect:addMod(xi.mod.DEX, 3)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.CHR, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
