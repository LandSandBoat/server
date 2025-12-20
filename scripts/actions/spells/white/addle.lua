-----------------------------------
-- Spell: Addle
-- Main effect: Increases the casting time of the target.
-- Sub effect: Lowers target magic accuracy.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onSpellSetup = function()
    return
    {
        skill        = xi.skill.ENFEEBLING_MAGIC,
        group        = xi.magic.spellGroup.WHITE,
        family       = xi.magic.spellFamily.ADDLE,
        element      = xi.element.FIRE,
        requirements =
        {
            jobs =
            {
                [xi.job.RDM] = 83,
                [xi.job.WHM] = 93,
            },
            cost = 36,
        },
        castTime     = 2,
        recast       = 20,
        animation    = 119,
        enmity       =
        {
            ce = 1,
            ve = 320,
        },
        range        = 20,
        target       = { xi.target.HOSTILE },
    }
end

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enfeebling.useEnfeeblingSpell(caster, target, spell)
end

return spellObject
