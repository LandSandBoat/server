-----------------------------------
-- ID: 6009
-- Item: Bowl of Mog Pudding
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP 7
-- MP 7
-- Vitality 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6009)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 7)
    target:addMod(xi.mod.MP, 7)
    target:addMod(xi.mod.VIT, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 7)
    target:delMod(xi.mod.MP, 7)
    target:delMod(xi.mod.VIT, 3)
end

return itemObject
