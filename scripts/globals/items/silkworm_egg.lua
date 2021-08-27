-----------------------------------
-- ID: 4526
-- Item: Silkworm Egg
-- Food Effect: 5 Mins, All Races
-----------------------------------
-- HP 12
-- MP 12
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4526)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 12)
    target:addMod(xi.mod.MP, 12)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 12)
    target:delMod(xi.mod.MP, 12)
end

return item_object
