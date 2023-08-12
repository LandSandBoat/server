-----------------------------------
-- xi.effect.SABER_DANCE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local saberDanceMerits = target:getMerit(xi.merit.SABER_DANCE)
    if saberDanceMerits > 5 then
        target:addMod(xi.mod.SAMBA_PDURATION, (saberDanceMerits - 5))
    end

    -- Does not stack with warrior Double Attack trait, so disable it
    if target:hasTrait(15) then -- TRAIT_DOUBLE_ATTACK
        target:delMod(xi.mod.DOUBLE_ATTACK, 10)
    end

    target:addMod(xi.mod.DOUBLE_ATTACK, effect:getPower())
    target:delStatusEffect(xi.effect.FAN_DANCE)
end

effectObject.onEffectTick = function(target, effect)
    local power = effect:getPower()
    local decayby = 0

    -- Double attack rate decays until 20% then stays there
    if power > 20 then
        decayby = 3
        effect:setPower(power - decayby)
        target:delMod(xi.mod.DOUBLE_ATTACK, decayby)
    end
end

effectObject.onEffectLose = function(target, effect)
    local saberDanceMerits = target:getMerit(xi.merit.SABER_DANCE)
    if saberDanceMerits > 1 then
        target:delMod(xi.mod.SAMBA_PDURATION, (saberDanceMerits - 5))
    end

    if target:hasTrait(15) then -- TRAIT_DOUBLE_ATTACK
        -- put Double Attack trait back on.
        target:addMod(xi.mod.DOUBLE_ATTACK, 10)
    end

    target:delMod(xi.mod.DOUBLE_ATTACK, effect:getPower())
end

return effectObject
