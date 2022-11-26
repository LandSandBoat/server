-----------------------------------
-- ID: 5929
-- Item: Ojo Rice Ball
-- Food Effect: 60 Mins, All Races
-----------------------------------
-- HP +50
-- Dexterity +5
-- Vitality +5
-- Character +5
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Attack +60
-- Defense +40
-- Triple Attack +2%
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5929)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 50)
    target:addMod(xi.mod.DEX, 5)
    target:addMod(xi.mod.VIT, 5)
    target:addMod(xi.mod.CHR, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 50)
    target:delMod(xi.mod.DEX, 5)
    target:delMod(xi.mod.VIT, 5)
    target:delMod(xi.mod.CHR, 5)
end

return itemObject
