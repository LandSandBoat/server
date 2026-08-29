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

-- Resist Traits
-- For mobs, usually only beastmen get these.
local resistTraits =
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
    -- Mobs and pets get filtered.

    -- Pets:
    -- Avatars get do not gain Arcana Killer from their DRK main job.
    -- Jug pets get innate killer modifiers. They don't need the job trait.
    -- Wyverns get innate killer modifiers + Job Traits.
    -- Automatons do not gain killer effects from their job.
    if
        not entity:isMob() and
        not entity:isPet()
    then
        return true
    end

    local traitId     = trait:getID()
    local isWyvernPet = entity:isPet() and entity:getPetID() == xi.petId.WYVERN
    local isBeastmen  = entity:getEcosystem() == xi.ecosystem.BEASTMEN

    if
        mobExcludedTraits[traitId] and
        not isWyvernPet
    then
        return false
    end

    -- TODO: Research if pets besides Wyverns ever gain Resist traits.
    -- Note: Wyverns can in fact gain Resist traits when their master utilizes Wyrm Mail.
    if resistTraits[traitId] then
        return isWyvernPet or isBeastmen
    end

    return true
end
