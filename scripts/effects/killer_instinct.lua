-----------------------------------
-- xi.effect.KILLER_INSTINCT
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- onUseAbilityKillerInstinct in BST job_utils assigns the pet's ecosystem Enum as the effect subPower.
    -- subPower is then used to grant the corresponding killer effect.
    local ecosystemCorrelationMap =
    {
        -- Pet Ecosystem(subPower), Corresponding killer modifier
        [xi.ecosystem.AMORPH]   = xi.mod.BIRD_KILLER,
        [xi.ecosystem.AQUAN]    = xi.mod.AMORPH_KILLER,
        [xi.ecosystem.BEAST]    = xi.mod.LIZARD_KILLER,
        [xi.ecosystem.BIRD]     = xi.mod.AQUAN_KILLER,
        [xi.ecosystem.LIZARD]   = xi.mod.VERMIN_KILLER,
        [xi.ecosystem.PLANTOID] = xi.mod.BEAST_KILLER,
        [xi.ecosystem.VERMIN]   = xi.mod.PLANTOID_KILLER,
    }

    local mod = ecosystemCorrelationMap[effect:getSubPower()]

    if mod then
        effect:addMod(mod, effect:getPower())
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
