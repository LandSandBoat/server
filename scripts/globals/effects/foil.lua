-----------------------------------
-- xi.effect.FOIL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SPECIAL_ATTACK_EVASION, effect:getPower())
end

-- https://www.ffxiah.com/forum/topic/56696/foil-potency-and-decay-testing/#3625559
effect_object.onEffectTick = function(target, effect)

    local power = effect:getPower()

    -- TODO: Verify Foil evasion floor when more enhancing magic duration+ gear is available or RDM can cast foil from Master Levels.
    if power > 0 then -- don't go negative. but we don't know what the floor of Foil is currently.

        local powerDecay = 3

        effect:setPower(power-powerDecay)
        target:delMod(xi.mod.SPECIAL_ATTACK_EVASION, powerDecay)
    end
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SPECIAL_ATTACK_EVASION, effect:getPower())
end

return effect_object
