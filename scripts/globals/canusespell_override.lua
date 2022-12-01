-----------------------------------
-- Can use spell override functionality
-- Used to allow cast of spells granted by job points
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/spell_data")

xi = xi or {}
xi.spells = xi.spells or {}

local jobPointSpellGiftMap =
{
    [xi.job.WHM] =
    {
        [xi.magic.spell.RERAISE_IV] = 100,
        [xi.magic.spell.FULL_CURE]  = 1200,
    },

    [xi.job.BLM] =
    {
        [xi.magic.spell.FIRE_VI]     = 100,
        [xi.magic.spell.BLIZZARD_VI] = 100,
        [xi.magic.spell.AERO_VI]     = 100,
        [xi.magic.spell.STONE_VI]    = 100,
        [xi.magic.spell.THUNDER_VI]  = 100,
        [xi.magic.spell.WATER_VI]    = 100,

        [xi.magic.spell.ASPIR_III]   = 550,

        [xi.magic.spell.DEATH]       = 1200,
    },

    [xi.job.RDM] =
    {
        [xi.magic.spell.FIRE_V]       = 100,
        [xi.magic.spell.BLIZZARD_V]   = 100,
        [xi.magic.spell.AERO_V]       = 100,
        [xi.magic.spell.STONE_V]      = 100,
        [xi.magic.spell.THUNDER_V]    = 100,
        [xi.magic.spell.WATER_V]      = 100,

        [xi.magic.spell.ADDLE_II]     = 550,
        [xi.magic.spell.DISTRACT_III] = 550,
        [xi.magic.spell.FRAZZLE_III]  = 550,

        [xi.magic.spell.REFRESH_III]  = 1200,
        [xi.magic.spell.TEMPER_II]    = 1200,
    },

    [xi.job.PLD] =
    {
        [xi.magic.spell.ENLIGHT_II] = 100,
    },

    [xi.job.DRK] =
    {
        [xi.magic.spell.ENDARK_II] = 100,
        [xi.magic.spell.DRAIN_III] = 100,
    },

    [xi.job.BRD] =
    {
        [xi.magic.spell.FIRE_THRENODY_II]      = 100,
        [xi.magic.spell.ICE_THRENODY_II]       = 100,
        [xi.magic.spell.WIND_THRENODY_II]      = 100,
        [xi.magic.spell.EARTH_THRENODY_II]     = 100,
        [xi.magic.spell.LIGHTNING_THRENODY_II] = 100,
        [xi.magic.spell.WATER_THRENODY_II]     = 100,
        [xi.magic.spell.LIGHT_THRENODY_II]     = 100,
        [xi.magic.spell.DARK_THRENODY_II]      = 100,
    },

    [xi.job.NIN] =
    {
        [xi.magic.spell.UTSUSEMI_SAN] = 100,
    },

    [xi.job.SCH] =
    {
        [xi.magic.spell.FIRESTORM_II]    = 100,
        [xi.magic.spell.HAILSTORM_II]    = 100,
        [xi.magic.spell.WINDSTORM_II]    = 100,
        [xi.magic.spell.SANDSTORM_II]    = 100,
        [xi.magic.spell.THUNDERSTORM_II] = 100,
        [xi.magic.spell.RAINSTORM_II]    = 100,
        [xi.magic.spell.AURORASTORM_II]  = 100,
        [xi.magic.spell.VOIDSTORM_II]    = 100,

        [xi.magic.spell.PYROHELIX_II]    = 1200,
        [xi.magic.spell.CRYOHELIX_II]    = 1200,
        [xi.magic.spell.ANEMOHELIX_II]   = 1200,
        [xi.magic.spell.GEOHELIX_II]     = 1200,
        [xi.magic.spell.LUMINOHELIX_II]  = 1200,
        [xi.magic.spell.NOCTOHELIX_II]   = 1200,
    },

    [xi.job.GEO] =
    {
        [xi.magic.spell.FIRE_V]       = 100,
        [xi.magic.spell.BLIZZARD_V]   = 100,
        [xi.magic.spell.AERO_V]       = 100,
        [xi.magic.spell.STONE_V]      = 100,
        [xi.magic.spell.THUNDER_V]    = 100,
        [xi.magic.spell.WATER_V]      = 100,

        [xi.magic.spell.FIRA_III]     = 1200,
        [xi.magic.spell.BLIZZARA_III] = 1200,
        [xi.magic.spell.AERA_III]     = 1200,
        [xi.magic.spell.STONERA_III]  = 1200,
        [xi.magic.spell.THUNDARA_III] = 1200,
        [xi.magic.spell.WATERA_III]   = 1200,
    },

    [xi.job.RUN] =
    {
        [xi.magic.spell.TEMPER] = 550,
    }
}

local function getSpellJobPointCostForJob(job, spellID)
    local jobGiftMap = jobPointSpellGiftMap[job]
    if jobGiftMap then
        local jobPointCost = jobGiftMap[spellID]

        if jobPointCost then
            return jobPointCost
        end
    end

    return -1
end

-- return true to indicate that the spell can indeed be cast
-- return false falls back to default behavior of checking main/sub job levels for cast availability
-- note: this only affects whether or not you are able to cast a spell in general, MP costs (if any) are still required.
xi.spells.canUseSpellOverride = function(player, spell)
    local job            = player:getMainJob()
    local spellID        = spell:getID()
    local jobPointsSpent = player:getSpentJobPoints()

    local jobPointCostForSpell = getSpellJobPointCostForJob(job, spellID)

    if jobPointCostForSpell == -1 then -- that job can't cast that spell no matter how many JP they have
        return false
    end

    if jobPointsSpent >= jobPointCostForSpell then
        return true
    end

    return false
end
