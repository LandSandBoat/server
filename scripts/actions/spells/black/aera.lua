-----------------------------------
-- Spell: Aera
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onSpellSetup = function()
    return
    {
        skill        = xi.skill.ELEMENTAL_MAGIC,
        group        = xi.magic.spellGroup.BLACK,
        family       = xi.magic.spellFamily.AERORA,
        element      = xi.element.WIND,
        requirements =
        {
            jobs =
            {
                [xi.job.GEO] = 35,
            },
            cost = 94,
        },
        castTime     = 1.5,
        recast       = 5,
        animation    = 895,
        range        = 10,
        target       = { xi.target.HOSTILE },
        aoe          =
        {
            affects = { xi.target.HOSTILE },
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
    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spellObject
