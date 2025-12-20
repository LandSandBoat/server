-----------------------------------
-- Spell: Embrava
-- Consumes 20% of your maximum MP.
-- Gradually restores target party member's HP and MP and increases attack speed.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onSpellSetup = function()
    return
    {
        skill        = xi.skill.ENHANCING_MAGIC,
        group        = xi.magic.spellGroup.WHITE,
        element      = xi.element.LIGHT,
        requirements =
        {
            special = xi.magic.spellReq.TABULA_RASA,
            jobs =
            {
                [xi.job.SCH] = 5,
            },
            cost = 1,
        },
        castTime     = 3,
        recast       = 6,
        animation    = 121,
        enmity       =
        {
            ce = 1,
            ve = 165,
        },
        range        = 20,
        target       = { xi.target.FRIENDLY },
        aoe          =
        {
            flags   = { xi.aoe.areaFlags.ACCESSION },
            affects = { xi.target.PARTY },
        },
    }
end

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSpell(caster, target, spell)
end

return spellObject
