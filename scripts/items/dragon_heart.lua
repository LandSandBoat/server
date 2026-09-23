-----------------------------------
-- ID: 4486
-- Item: Dragon Heart
-- Food Effect: 5 minutes, Galka only
-----------------------------------
-- Strength: 7
-- Intelligence: -9
-- MP: -40
-- HP: 40
-- Demon Killer: 10
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_MEAT)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 5 * 60, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.INT, -9)
    effect:addMod(xi.mod.FOOD_MP, -40)
    effect:addMod(xi.mod.FOOD_HP, 40)
    effect:addMod(xi.mod.DEMON_KILLER, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
