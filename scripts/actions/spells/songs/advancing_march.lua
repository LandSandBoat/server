-----------------------------------
-- Spell: Advancing March
-- Gives party members Haste
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onSpellSetup = function()
    return
    {
        skill        = xi.skill.SINGING,
        group        = xi.magic.spellGroup.SONG,
        family       = xi.magic.spellFamily.MARCH,
        element      = xi.element.THUNDER,
        requirements =
        {
            jobs =
            {
                [xi.job.BRD] = 29,
            },
        },
        castTime     = 8,
        recast       = 24,
        animation    = 434,
        enmity       =
        {
            ce = 11,
            ve = 44,
        },
        range        = 20,
        target       = { xi.target.SELF, xi.target.PARTY },
        aoe          =
        {
            affects = { xi.target.SELF, xi.target.PARTY },
            sphere  =
            {
                origin = xi.aoe.sphere.CASTER,
                radius = 10,
            },
        },
    }
end

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSong(caster, target, spell)
end

return spellObject
