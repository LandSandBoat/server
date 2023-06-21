-----------------------------------
-- ID: 6465
-- Item: behemoth_steak_+1
-- Food Effect: 240Min, All Races
-----------------------------------
-- HP +45
-- STR +8
-- DEX +8
-- INT -4
-- Attack +24% (cap 165)
-- Ranged Attack +24% (cap 165)
-- Triple Attack +2%
-- Lizard Killer +5
-- hHP +5
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 6465)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 45)
    target:addMod(xi.mod.STR, 8)
    target:addMod(xi.mod.DEX, 8)
    target:addMod(xi.mod.INT, -4)
    target:addMod(xi.mod.FOOD_ATTP, 24)
    target:addMod(xi.mod.FOOD_ATT_CAP, 165)
    target:addMod(xi.mod.FOOD_RATTP, 24)
    target:addMod(xi.mod.FOOD_RATT_CAP, 165)
    target:addMod(xi.mod.TRIPLE_ATTACK, 2)
    target:addMod(xi.mod.LIZARD_KILLER, 5)
    target:addMod(xi.mod.HPHEAL, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 45)
    target:delMod(xi.mod.STR, 8)
    target:delMod(xi.mod.DEX, 8)
    target:delMod(xi.mod.INT, -4)
    target:delMod(xi.mod.FOOD_ATTP, 24)
    target:delMod(xi.mod.FOOD_ATT_CAP, 165)
    target:delMod(xi.mod.FOOD_RATTP, 24)
    target:delMod(xi.mod.FOOD_RATT_CAP, 165)
    target:delMod(xi.mod.TRIPLE_ATTACK, 2)
    target:delMod(xi.mod.LIZARD_KILLER, 5)
    target:delMod(xi.mod.HPHEAL, 5)
end

return itemObject
