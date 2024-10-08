-----------------------------------
-- xi.effect.SLEEP
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Immunobreak reset.
    target:setMod(xi.mod.SLEEP_IMMUNOBREAK, 0)

    if effect:getTier() > 0 then
        -- bio with subpower > 0 is a signal that we don't wake up targets from this dot damage
        -- dot damage = sleep subpower
        -- see mobskills/nightmare.lua for full explanation
        local attpReduction = 10
        if effect:getTier() > 1 then
            attpReduction = effect:getSubPower()
        end

        target:delStatusEffectSilent(xi.effect.BIO)
        target:addStatusEffect(xi.effect.BIO, effect:getSubPower(), 3, effect:getDuration(), 0, attpReduction, 1)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
