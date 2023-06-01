-----------------------------------
-- ID: 5569
-- Item: puk_egg
-- Food Effect: 5Min, All Races
-----------------------------------
-- Health 6
-- Magic 6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5569)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 6)
    target:addMod(xi.mod.MP, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 6)
    target:delMod(xi.mod.MP, 6)
end

return itemObject
