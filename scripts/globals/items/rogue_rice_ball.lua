-----------------------------------
-- ID: 4604
-- Item: Rogue Rice Ball
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +12
-- Vit +3
-- hHP +2
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Def +50
-- Beast Killer (guesstimated 5%)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4604)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 12)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.HPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 12)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.HPHEAL, 2)
end

return item_object
