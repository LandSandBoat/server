-----------------------------------
-- ID: 5636
-- Item: shrimp_cracker_+1
-- Food Effect: 5Min, All Races
-----------------------------------
-- Vitality 2
-- Defense +10
-- Amorph Killer 12
-- Resist Virus 12
-- HP Recovered While Healing 9
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.DEF, 10)
    effect:addMod(xi.mod.AMORPH_KILLER, 12)
    effect:addMod(xi.mod.VIRUSRES, 12)
    effect:addMod(xi.mod.HPHEAL, 9)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
