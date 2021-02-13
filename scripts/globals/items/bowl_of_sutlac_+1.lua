-----------------------------------
-- ID: 5578
-- Item: Bowl of Sutlac
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10
-- MP +10
-- INT +2
-- HP Recovered while healing +1
-- MP Recovered while healing +1
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5578)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.HPHEAL, 1)
    target:addMod(tpz.mod.MPHEAL, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.HPHEAL, 1)
    target:delMod(tpz.mod.MPHEAL, 1)
end

return item_object
