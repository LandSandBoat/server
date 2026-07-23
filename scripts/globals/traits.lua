-----------------------------------
-- Job trait application filtering
-----------------------------------
xi = xi or {}
xi.traits = xi.traits or {}

-- Traits monsters never get
local mobExcludedTraits =
{
    [xi.trait.BEAST_KILLER   ] = true,
    [xi.trait.PLANTOID_KILLER] = true,
    [xi.trait.VERMIN_KILLER  ] = true,
    [xi.trait.LIZARD_KILLER  ] = true,
    [xi.trait.BIRD_KILLER    ] = true,
    [xi.trait.AMORPH_KILLER  ] = true,
    [xi.trait.AQUAN_KILLER   ] = true,
    [xi.trait.UNDEAD_KILLER  ] = true,
    [xi.trait.ARCANA_KILLER  ] = true,
    [xi.trait.DEMON_KILLER   ] = true,
    [xi.trait.DRAGON_KILLER  ] = true,
    [xi.trait.SMITE          ] = true,
    [xi.trait.FENCER         ] = true,
}

-- Traits only beastmen monsters get
local beastmenOnlyTraits =
{
    [xi.trait.RESIST_SLEEP   ] = true,
    [xi.trait.RESIST_POISON  ] = true,
    [xi.trait.RESIST_PARALYZE] = true,
    [xi.trait.RESIST_BLIND   ] = true,
    [xi.trait.RESIST_SILENCE ] = true,
    [xi.trait.RESIST_PETRIFY ] = true,
    [xi.trait.RESIST_VIRUS   ] = true,
    [xi.trait.RESIST_CURSE   ] = true,
    [xi.trait.RESIST_STUN    ] = true,
    [xi.trait.RESIST_BIND    ] = true,
    [xi.trait.RESIST_GRAVITY ] = true,
    [xi.trait.RESIST_SLOW    ] = true,
    [xi.trait.RESIST_CHARM   ] = true,
    [xi.trait.RESIST_AMNESIA ] = true,
}

-- Should the entity be granted a given trait.
-- Return false to prevent the trait from being applied.
-- Zone available for eventual expansion-specific rules.
--
-- Wildly under-researched, only add confirmed rules.
---@param trait CTrait
---@param entity CBaseEntity
---@param zone CZone?
---@return boolean
xi.traits.canApplyTrait = function(trait, entity, zone)
    -- Only monsters are filtered, everything else gets its traits for now
    if not entity:isMob() then
        return true
    end

    local traitId = trait:getID()

    if mobExcludedTraits[traitId] then
        return false
    end

    if beastmenOnlyTraits[traitId] then
        return entity:getEcosystem() == xi.ecosystem.BEASTMEN
    end

    return true
end
