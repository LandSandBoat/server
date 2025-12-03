-----------------------------------
-- ID: 6406
-- Item: pork_cutlet_rice_bowl
-- Food Effect: 180Min, All Races
-----------------------------------
-- HP +60
-- MP +60
-- STR +7
-- VIT +3
-- AGI +5
-- INT -7
-- Fire resistance +20
-- Attack +23% (cap 125)
-- Ranged Attack +23% (cap 125)
-- Store TP +4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 60)
    effect:addMod(xi.mod.FOOD_MP, 60)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.AGI, 5)
    effect:addMod(xi.mod.INT, -7)
    effect:addMod(xi.mod.FIRE_MEVA, 20)
    effect:addMod(xi.mod.FOOD_ATTP, 23)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 125)
    effect:addMod(xi.mod.FOOD_RATTP, 23)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 125)
    effect:addMod(xi.mod.STORETP, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
