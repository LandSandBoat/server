-----------------------------------
-- ID: 5787
-- Item: pipira
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Dexterity 2
-- Mind -4
-- Attack % 14.5
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getRace() ~= xi.race.MITHRA then
        result = xi.msg.basic.CANNOT_EAT
    end

    if target:getMod(xi.mod.EAT_RAW_FISH) == 1 then
        result = 0
    end

    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5787)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.MND, -4)
    target:addMod(xi.mod.FOOD_ATTP, 14)
    target:addMod(xi.mod.FOOD_ATT_CAP, 60)
    target:addMod(xi.mod.FOOD_RATTP, 14)
    target:addMod(xi.mod.FOOD_RATT_CAP, 60)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.MND, -4)
    target:delMod(xi.mod.FOOD_ATTP, 14)
    target:delMod(xi.mod.FOOD_ATT_CAP, 60)
    target:delMod(xi.mod.FOOD_RATTP, 14)
    target:delMod(xi.mod.FOOD_RATT_CAP, 60)
end

return itemObject
