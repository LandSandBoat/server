-----------------------------------
-- ID: 4485
-- Item: noble_lady
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Dexterity 3
-- Mind -5
-- Charisma 3
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getRace() ~= xi.race.MITHRA then
        result = xi.msg.basic.CANNOT_EAT
    end

    if target:getMod(xi.mod.EAT_RAW_FISH) == 1 then
        result = 0
    end

    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4485)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.MND, -5)
    target:addMod(xi.mod.CHR, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.MND, -5)
    target:delMod(xi.mod.CHR, 3)
end

return itemObject
