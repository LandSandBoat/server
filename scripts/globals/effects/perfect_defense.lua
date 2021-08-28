-----------------------------------
-- xi.effect.PERFECT_DEFENSE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.UDMGPHYS, -effect:getPower())
    target:addMod(xi.mod.UDMGBREATH, -effect:getPower())
    target:addMod(xi.mod.UDMGMAGIC, -effect:getPower())
    target:addMod(xi.mod.UDMGRANGE, -effect:getPower())
    target:addMod(xi.mod.SLEEPRES, effect:getPower())
    target:addMod(xi.mod.POISONRES, effect:getPower())
    target:addMod(xi.mod.PARALYZERES, effect:getPower())
    target:addMod(xi.mod.BLINDRES, effect:getPower())
    target:addMod(xi.mod.SILENCERES, effect:getPower())
    target:addMod(xi.mod.BINDRES, effect:getPower())
    target:addMod(xi.mod.CURSERES, effect:getPower())
    target:addMod(xi.mod.SLOWRES, effect:getPower())
    target:addMod(xi.mod.STUNRES, effect:getPower())
    target:addMod(xi.mod.CHARMRES, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
    if (effect:getTickCount() > ((effect:getDuration() / effect:getTick())/2)) then
        if (effect:getPower() > 2) then
            effect:setPower(effect:getPower() - 200)
            target:delMod(xi.mod.UDMGPHYS, -200)
            target:delMod(xi.mod.UDMGBREATH, -200)
            target:delMod(xi.mod.UDMGMAGIC, -300)
            target:delMod(xi.mod.UDMGRANGE, -200)
            target:delMod(xi.mod.SLEEPRES, 2)
            target:delMod(xi.mod.POISONRES, 2)
            target:delMod(xi.mod.PARALYZERES, 2)
            target:delMod(xi.mod.BLINDRES, 2)
            target:delMod(xi.mod.SILENCERES, 2)
            target:delMod(xi.mod.BINDRES, 2)
            target:delMod(xi.mod.CURSERES, 2)
            target:delMod(xi.mod.SLOWRES, 2)
            target:delMod(xi.mod.STUNRES, 2)
            target:delMod(xi.mod.CHARMRES, 2)
        end
    end
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.UDMGPHYS, -effect:getPower())
    target:delMod(xi.mod.UDMGBREATH, -effect:getPower())
    target:delMod(xi.mod.UDMGMAGIC, -effect:getSubPower())
    target:delMod(xi.mod.UDMGRANGE, -effect:getPower())
    target:delMod(xi.mod.SLEEPRES, effect:getPower())
    target:delMod(xi.mod.POISONRES, effect:getPower())
    target:delMod(xi.mod.PARALYZERES, effect:getPower())
    target:delMod(xi.mod.BLINDRES, effect:getPower())
    target:delMod(xi.mod.SILENCERES, effect:getPower())
    target:delMod(xi.mod.BINDRES, effect:getPower())
    target:delMod(xi.mod.CURSERES, effect:getPower())
    target:delMod(xi.mod.SLOWRES, effect:getPower())
    target:delMod(xi.mod.STUNRES, effect:getPower())
    target:delMod(xi.mod.CHARMRES, effect:getPower())
end

return effect_object
