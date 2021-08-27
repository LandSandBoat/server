-----------------------------------
-- ID: 5738
-- Item: chunk_of_sweet_lizard
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP 5
-- MP 5
-- Dexterity 1
-- hHP +2
-- hMP +2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5738)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 5)
    target:addMod(xi.mod.MP, 5)
    target:addMod(xi.mod.DEX, 1)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 5)
    target:delMod(xi.mod.MP, 5)
    target:delMod(xi.mod.DEX, 1)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 2)
end

return item_object
