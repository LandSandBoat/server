-----------------------------------
-- ID: 6274
-- Item: pukatrice_egg
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +15
-- MP +15
-- STR +2
-- Fire resistance +20
-- Attack +20% (cap 85)
-- Ranged Attack +20% (cap 85)
-- Subtle Blow +8
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6274)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 15)
    target:addMod(xi.mod.MP, 15)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.FIRE_RES, 20)
    target:addMod(xi.mod.FOOD_ATTP, 20)
    target:addMod(xi.mod.FOOD_ATT_CAP, 85)
    target:addMod(xi.mod.FOOD_RATTP, 20)
    target:addMod(xi.mod.FOOD_RATT_CAP, 85)
    target:addMod(xi.mod.SUBTLE_BLOW, 8)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 15)
    target:delMod(xi.mod.MP, 15)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.FIRE_RES, 20)
    target:delMod(xi.mod.FOOD_ATTP, 20)
    target:delMod(xi.mod.FOOD_ATT_CAP, 85)
    target:delMod(xi.mod.FOOD_RATTP, 20)
    target:delMod(xi.mod.FOOD_RATT_CAP, 85)
    target:delMod(xi.mod.SUBTLE_BLOW, 8)
end

return item_object
