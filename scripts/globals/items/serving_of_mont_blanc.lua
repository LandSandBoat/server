-----------------------------------
-- ID: 5557
-- Item: Serving of Mont Blanc
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +8
-- MP +10
-- Intelligence +1
-- HP Recoverd while healing 1
-- MP Recovered while healing 1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5557)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 8)
    target:addMod(xi.mod.MP, 10)
    target:addMod(xi.mod.INT, 1)
    target:addMod(xi.mod.HPHEAL, 1)
    target:addMod(xi.mod.MPHEAL, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 8)
    target:delMod(xi.mod.MP, 10)
    target:delMod(xi.mod.INT, 1)
    target:delMod(xi.mod.HPHEAL, 1)
    target:delMod(xi.mod.MPHEAL, 1)
end

return item_object
