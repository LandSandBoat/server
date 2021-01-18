-----------------------------------
-- ID: 4278
-- Item: Shogun Rice Ball
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +20
-- Dex +4
-- Vit +4
-- Chr +4
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Atk +50
-- Def +30
-- Double Attack +5%
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4278)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.CHR, 4)

end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.CHR, 4)
end

return item_object
