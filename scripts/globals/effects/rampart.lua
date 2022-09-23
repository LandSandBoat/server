-----------------------------------
-- xi.effect.RAMPART
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local power = effect:getPower()
    target:addMod(xi.mod.UDMGPHYS, -power)
    target:addMod(xi.mod.UDMGBREATH, -power)
    target:addMod(xi.mod.UDMGMAGIC, -power)
    target:addMod(xi.mod.UDMGRANGE, -power)

    if target:isPC() and target:hasTrait(77) then -- Iron Will
        target:addMod(xi.mod.SPELLINTERRUPT, target:getMerit(xi.merit.IRON_WILL))
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local power = effect:getPower()
    target:delMod(xi.mod.UDMGPHYS, -power)
    target:delMod(xi.mod.UDMGBREATH, -power)
    target:delMod(xi.mod.UDMGMAGIC, -power)
    target:delMod(xi.mod.UDMGRANGE, -power)

    if target:isPC() and target:hasTrait(77) then -- Iron Will
        target:delMod(xi.mod.SPELLINTERRUPT, target:getMerit(xi.merit.IRON_WILL))
    end
end

return effect_object
