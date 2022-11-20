-----------------------------------
-- xi.effect.TABULA_RASA
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local regen = effect:getSubPower()
    local helix = effect:getPower()

    if
        target:hasStatusEffect(xi.effect.LIGHT_ARTS) or
        target:hasStatusEffect(xi.effect.ADDENDUM_WHITE)
    then
        target:addMod(xi.mod.BLACK_MAGIC_COST, -30)
        target:addMod(xi.mod.BLACK_MAGIC_CAST, -30)
        target:addMod(xi.mod.BLACK_MAGIC_RECAST, -30)
        target:addMod(xi.mod.LIGHT_ARTS_REGEN, math.ceil(regen / 1.5))
        target:addMod(xi.mod.REGEN_DURATION, math.ceil((regen * 2) / 1.5))
        target:addMod(xi.mod.HELIX_EFFECT, helix)
        target:addMod(xi.mod.HELIX_DURATION, 108)
    elseif
        target:hasStatusEffect(xi.effect.DARK_ARTS) or
        target:hasStatusEffect(xi.effect.ADDENDUM_BLACK)
    then
        target:addMod(xi.mod.WHITE_MAGIC_COST, -30)
        target:addMod(xi.mod.WHITE_MAGIC_CAST, -30)
        target:addMod(xi.mod.WHITE_MAGIC_RECAST, -30)
        target:addMod(xi.mod.LIGHT_ARTS_REGEN, regen)
        target:addMod(xi.mod.REGEN_DURATION, regen * 2)
        target:addMod(xi.mod.HELIX_EFFECT, math.ceil(helix / 1.5))
        target:addMod(xi.mod.HELIX_DURATION, 36)
    else
        target:addMod(xi.mod.BLACK_MAGIC_COST, -10)
        target:addMod(xi.mod.BLACK_MAGIC_CAST, -10)
        target:addMod(xi.mod.BLACK_MAGIC_RECAST, -10)
        target:addMod(xi.mod.WHITE_MAGIC_COST, -10)
        target:addMod(xi.mod.WHITE_MAGIC_CAST, -10)
        target:addMod(xi.mod.WHITE_MAGIC_RECAST, -10)
        target:addMod(xi.mod.LIGHT_ARTS_REGEN, regen)
        target:addMod(xi.mod.REGEN_DURATION, regen * 2)
        target:addMod(xi.mod.HELIX_EFFECT, helix)
        target:addMod(xi.mod.HELIX_DURATION, 108)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local regen = effect:getSubPower()
    local helix = effect:getPower()

    if
        target:hasStatusEffect(xi.effect.LIGHT_ARTS) or
        target:hasStatusEffect(xi.effect.ADDENDUM_WHITE)
    then
        target:delMod(xi.mod.BLACK_MAGIC_COST, -30)
        target:delMod(xi.mod.BLACK_MAGIC_CAST, -30)
        target:delMod(xi.mod.BLACK_MAGIC_RECAST, -30)
        target:delMod(xi.mod.LIGHT_ARTS_REGEN, math.ceil(regen / 1.5))
        target:delMod(xi.mod.REGEN_DURATION, math.ceil((regen * 2) / 1.5))
        target:delMod(xi.mod.HELIX_EFFECT, helix)
        target:delMod(xi.mod.HELIX_DURATION, 108)
    elseif
        target:hasStatusEffect(xi.effect.DARK_ARTS) or
        target:hasStatusEffect(xi.effect.ADDENDUM_BLACK)
    then
        target:delMod(xi.mod.WHITE_MAGIC_COST, -30)
        target:delMod(xi.mod.WHITE_MAGIC_CAST, -30)
        target:delMod(xi.mod.WHITE_MAGIC_RECAST, -30)
        target:delMod(xi.mod.LIGHT_ARTS_REGEN, regen)
        target:delMod(xi.mod.REGEN_DURATION, regen * 2)
        target:delMod(xi.mod.HELIX_EFFECT, math.ceil(helix / 1.5))
        target:delMod(xi.mod.HELIX_DURATION, 36)
    else
        target:delMod(xi.mod.BLACK_MAGIC_COST, -10)
        target:delMod(xi.mod.BLACK_MAGIC_CAST, -10)
        target:delMod(xi.mod.BLACK_MAGIC_RECAST, -10)
        target:delMod(xi.mod.WHITE_MAGIC_COST, -10)
        target:delMod(xi.mod.WHITE_MAGIC_CAST, -10)
        target:delMod(xi.mod.WHITE_MAGIC_RECAST, -10)
        target:delMod(xi.mod.LIGHT_ARTS_REGEN, regen)
        target:delMod(xi.mod.REGEN_DURATION, regen * 2)
        target:delMod(xi.mod.HELIX_EFFECT, helix)
        target:delMod(xi.mod.HELIX_DURATION, 108)
    end
end

return effectObject
