-----------------------------------
-- ID: 5928
-- Item: Himesama Rice Ball
-- Food Effect: 30 Mins, All Races
-----------------------------------
-- HP +25
-- Dexterity +4
-- Vitality +4
-- Character +4
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Attack +60
-- Defense +40
-- Triple Attack +1%
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
    effect:addMod(xi.mod.FOOD_HP, 25)
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.CHR, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
