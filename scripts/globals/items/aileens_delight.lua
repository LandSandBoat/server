-----------------------------------
-- ID: 5674
-- Item: Aileen's Delight
-- Food Effect: 60 Min, All Races
-----------------------------------
-- HP +50
-- MP +50
-- STR +4
-- DEX +4
-- VIT +4
-- AGI +4
-- INT +4
-- MND +4
-- CHR +4
-- MP recovered while healing +2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5674)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 50)
    target:addMod(xi.mod.MP, 50)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.INT, 4)
    target:addMod(xi.mod.MND, 4)
    target:addMod(xi.mod.CHR, 4)
    target:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 50)
    target:delMod(xi.mod.MP, 50)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.INT, 4)
    target:delMod(xi.mod.MND, 4)
    target:delMod(xi.mod.CHR, 4)
    target:delMod(xi.mod.MPHEAL, 2)
end

return itemObject
