-----------------------------------
-- ID: 4446
-- Item: pumpkin_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 40
-- Agility -1
-- Intelligence 3
-- Charisma -2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4446)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 40)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.CHR, -2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 40)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.CHR, -2)
end

return item_object
