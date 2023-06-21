-----------------------------------
-- ID: 6464
-- Item: behemoth_steak
-- Food Effect: 180Min, All Races
-----------------------------------
-- HP +40
-- STR +7
-- DEX +7
-- INT -3
-- Attack +23% (cap 160)
-- Ranged Attack +23% (cap 160)
-- Triple Attack +1%
-- Lizard Killer +4
-- hHP +4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 6464)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 40)
    target:addMod(xi.mod.STR, 7)
    target:addMod(xi.mod.DEX, 7)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.FOOD_ATTP, 23)
    target:addMod(xi.mod.FOOD_ATT_CAP, 160)
    target:addMod(xi.mod.FOOD_RATTP, 23)
    target:addMod(xi.mod.FOOD_RATT_CAP, 160)
    target:addMod(xi.mod.TRIPLE_ATTACK, 1)
    target:addMod(xi.mod.LIZARD_KILLER, 4)
    target:addMod(xi.mod.HPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 40)
    target:delMod(xi.mod.STR, 7)
    target:delMod(xi.mod.DEX, 7)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.FOOD_ATTP, 23)
    target:delMod(xi.mod.FOOD_ATT_CAP, 160)
    target:delMod(xi.mod.FOOD_RATTP, 23)
    target:delMod(xi.mod.FOOD_RATT_CAP, 160)
    target:delMod(xi.mod.TRIPLE_ATTACK, 1)
    target:delMod(xi.mod.LIZARD_KILLER, 4)
    target:delMod(xi.mod.HPHEAL, 4)
end

return itemObject
