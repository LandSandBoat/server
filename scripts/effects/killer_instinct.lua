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
        [xi.ecosystem.AMORPH]   = { intimidate = xi.mod.BIRD_KILLER,     damage = xi.mod.BIRD_KILLER_DMG_BONUS },
        [xi.ecosystem.AQUAN]    = { intimidate = xi.mod.AMORPH_KILLER,   damage = xi.mod.AMORPH_KILLER_DMG_BONUS },
        [xi.ecosystem.BEAST]    = { intimidate = xi.mod.LIZARD_KILLER,   damage = xi.mod.LIZARD_KILLER_DMG_BONUS },
        [xi.ecosystem.BIRD]     = { intimidate = xi.mod.AQUAN_KILLER,    damage = xi.mod.AQUAN_KILLER_DMG_BONUS },
        [xi.ecosystem.LIZARD]   = { intimidate = xi.mod.VERMIN_KILLER,   damage = xi.mod.VERMIN_KILLER_DMG_BONUS },
        [xi.ecosystem.PLANTOID] = { intimidate = xi.mod.BEAST_KILLER,    damage = xi.mod.BEAST_KILLER_DMG_BONUS },
        [xi.ecosystem.VERMIN]   = { intimidate = xi.mod.PLANTOID_KILLER, damage = xi.mod.PLANTOID_KILLER_DMG_BONUS },
    }

    local mod = ecosystemCorrelationMap[effect:getSubPower()]

    if mod then
        effect:addMod(mod.intimidate, effect:getPower())
        effect:addMod(mod.damage, effect:getPower())
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
