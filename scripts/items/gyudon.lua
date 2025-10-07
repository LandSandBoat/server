-----------------------------------
-- ID: 6686
-- Item: gyudon
-- Food Effect: 30Min, All Races
-----------------------------------
-- Enmity -5
-- Double Attack % 5
-- Weapon Skill Damage % 5
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
    target:addMod(xi.mod.ENMITY, -5)
    target:addMod(xi.mod.DOUBLE_ATTACK, 5)
    target:addMod(xi.mod.ALL_WSDMG_ALL_HITS, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ENMITY, -5)
    target:delMod(xi.mod.DOUBLE_ATTACK, 5)
    target:delMod(xi.mod.ALL_WSDMG_ALL_HITS, 5)
end

return itemObject
