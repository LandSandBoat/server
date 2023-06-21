-----------------------------------
-- ID: 5564
-- Item: Chunk of Hydra Meat
-- Effect: 5 Minutes, food effect, Galka Only
-----------------------------------
-- HP 10
-- MP -10
-- Strength +6
-- Intelligence -8
-- Demon Killer 10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5564)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 10)
    target:addMod(xi.mod.MP, -10)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.INT, -8)
    target:addMod(xi.mod.DEMON_KILLER, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 10)
    target:delMod(xi.mod.MP, -10)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.INT, -8)
    target:delMod(xi.mod.DEMON_KILLER, 10)
end

return itemObject
