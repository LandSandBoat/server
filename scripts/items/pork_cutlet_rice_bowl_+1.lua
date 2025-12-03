-----------------------------------
-- ID: 6407
-- Item: pork_cutlet_rice_bowl_+1
-- Food Effect: 240Min, All Races
-----------------------------------
-- HP +65
-- MP +65
-- STR +8
-- VIT +4
-- AGI +6
-- INT -8
-- Fire resistance +21
-- Attack +24% (cap 130)
-- Ranged Attack +24% (cap 130)
-- Store TP +5
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
    effect:addMod(xi.mod.FOOD_HP, 65)
    effect:addMod(xi.mod.FOOD_MP, 65)
    effect:addMod(xi.mod.STR, 8)
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.AGI, 6)
    effect:addMod(xi.mod.INT, -8)
    effect:addMod(xi.mod.FIRE_MEVA, 21)
    effect:addMod(xi.mod.FOOD_ATTP, 24)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 130)
    effect:addMod(xi.mod.FOOD_RATTP, 24)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 130)
    effect:addMod(xi.mod.STORETP, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
