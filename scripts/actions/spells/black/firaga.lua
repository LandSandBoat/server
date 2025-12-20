-----------------------------------
-- Spell: Firaga
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onSpellSetup = function()
    return
    {
        skill        = xi.skill.ELEMENTAL_MAGIC,
        group        = xi.magic.spellGroup.BLACK,
        family       = xi.magic.spellFamily.FIRAGA,
        element      = xi.element.FIRE,
        requirements =
        {
            jobs =
            {
                [xi.job.BLM] = 28,
            },
            cost = 57,
        },
        castTime     = 2,
        recast       = 5,
        animation    = 174,
        range        = 20,
        target       = { xi.target.HOSTILE },
        aoe          =
        {
            affects = { xi.target.HOSTILE },
            sphere  =
            {
                origin = xi.aoe.sphere.TARGET,
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
