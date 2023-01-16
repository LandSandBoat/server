-----------------------------------
-- xi.effect.PROWESS
-- "Killer" effects bonus
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VERMIN_KILLER, effect:getPower())
    target:addMod(xi.mod.BIRD_KILLER, effect:getPower())
    target:addMod(xi.mod.AMORPH_KILLER, effect:getPower())
    target:addMod(xi.mod.LIZARD_KILLER, effect:getPower())
    target:addMod(xi.mod.AQUAN_KILLER, effect:getPower())
    target:addMod(xi.mod.PLANTOID_KILLER, effect:getPower())
    target:addMod(xi.mod.BEAST_KILLER, effect:getPower())
    target:addMod(xi.mod.UNDEAD_KILLER, effect:getPower())
    target:addMod(xi.mod.ARCANA_KILLER, effect:getPower())
    target:addMod(xi.mod.DRAGON_KILLER, effect:getPower())
    target:addMod(xi.mod.DEMON_KILLER, effect:getPower())
    target:addMod(xi.mod.EMPTY_KILLER, effect:getPower())
    -- target:addMod(xi.mod.HUMANOID_KILLER, effect:getPower())
    target:addMod(xi.mod.LUMINIAN_KILLER, effect:getPower())
    target:addMod(xi.mod.LUMINION_KILLER, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VERMIN_KILLER, effect:getPower())
    target:delMod(xi.mod.BIRD_KILLER, effect:getPower())
    target:delMod(xi.mod.AMORPH_KILLER, effect:getPower())
    target:delMod(xi.mod.LIZARD_KILLER, effect:getPower())
    target:delMod(xi.mod.AQUAN_KILLER, effect:getPower())
    target:delMod(xi.mod.PLANTOID_KILLER, effect:getPower())
    target:delMod(xi.mod.BEAST_KILLER, effect:getPower())
    target:delMod(xi.mod.UNDEAD_KILLER, effect:getPower())
    target:delMod(xi.mod.ARCANA_KILLER, effect:getPower())
    target:delMod(xi.mod.DRAGON_KILLER, effect:getPower())
    target:delMod(xi.mod.DEMON_KILLER, effect:getPower())
    target:delMod(xi.mod.EMPTY_KILLER, effect:getPower())
    -- target:delMod(xi.mod.HUMANOID_KILLER, effect:getPower())
    target:delMod(xi.mod.LUMINIAN_KILLER, effect:getPower())
    target:delMod(xi.mod.LUMINION_KILLER, effect:getPower())
end

return effectObject
