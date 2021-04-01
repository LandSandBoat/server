-----------------------------------
-- xi.effect.ASYLUM
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SLEEPRES, 98)
    target:addMod(xi.mod.POISONRES, 98)
    target:addMod(xi.mod.PARALYZERES, 98)
    target:addMod(xi.mod.BLINDRES, 98)
    target:addMod(xi.mod.SILENCERES, 98)
    target:addMod(xi.mod.VIRUSRES, 98)
    target:addMod(xi.mod.PETRIFYRES, 98)
    target:addMod(xi.mod.BINDRES, 98)
    target:addMod(xi.mod.CURSERES, 98)
    target:addMod(xi.mod.GRAVITYRES, 98)
    target:addMod(xi.mod.SLOWRES, 98)
    target:addMod(xi.mod.STUNRES, 98)
    target:addMod(xi.mod.CHARMRES, 98)
    target:addMod(xi.mod.AMNESIARES, 98)
    target:addMod(xi.mod.LULLABYRES, 98)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SLEEPRES, 98)
    target:delMod(xi.mod.POISONRES, 98)
    target:delMod(xi.mod.PARALYZERES, 98)
    target:delMod(xi.mod.BLINDRES, 98)
    target:delMod(xi.mod.SILENCERES, 98)
    target:delMod(xi.mod.VIRUSRES, 98)
    target:delMod(xi.mod.PETRIFYRES, 98)
    target:delMod(xi.mod.BINDRES, 98)
    target:delMod(xi.mod.CURSERES, 98)
    target:delMod(xi.mod.GRAVITYRES, 98)
    target:delMod(xi.mod.SLOWRES, 98)
    target:delMod(xi.mod.STUNRES, 98)
    target:delMod(xi.mod.CHARMRES, 98)
    target:delMod(xi.mod.AMNESIARES, 98)
    target:delMod(xi.mod.LULLABYRES, 98)
end

return effect_object
