-----------------------------------
-- ID: 4494
-- Item: pot_of_san_dorian_tea
-- Food Effect: 180Min, All Races
-----------------------------------
-- Vitality -2
-- Charisma 2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4494)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, -2)
    target:addMod(xi.mod.CHR, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, -2)
    target:delMod(xi.mod.CHR, 2)
end

return itemObject
