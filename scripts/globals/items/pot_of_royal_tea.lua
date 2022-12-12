-----------------------------------
-- ID: 4524
-- Item: pot_of_royal_tea
-- Food Effect: 240Min, All Races
-----------------------------------
-- Vitality -1
-- Charisma 3
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4524)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.CHR, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.CHR, 3)
end

return itemObject
