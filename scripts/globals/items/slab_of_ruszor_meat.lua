-----------------------------------
-- ID: 5755
-- Item: Slab of Ruszor Meat
-- Food Effect: 30Min, Galka only
-----------------------------------
-- Strength 5
-- Intelligence -7
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getRace() ~= xi.race.GALKA then
        result = xi.msg.basic.CANNOT_EAT
    end

    if target:getMod(xi.mod.EAT_RAW_MEAT) == 1 then
        result = 0
    end

    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5755)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 5)
    target:addMod(xi.mod.INT, -7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 5)
    target:delMod(xi.mod.INT, -7)
end

return itemObject
