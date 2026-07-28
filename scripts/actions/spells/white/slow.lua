-----------------------------------
-- Spell: Slow
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        effectId       = xi.effect.SLOW,
        power          = utils.clamp(1825 + (caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)) * 73 / 5, 730, 2920),
        duration       = 180,
        tier           = 3,
        magicalElement = xi.element.EARTH,
        actorStat      = xi.mod.MND,
        skillType      = xi.skill.ENFEEBLING_MAGIC,
        spellGroup     = xi.magic.spellGroup.WHITE,
        bonusMacc      = 10,
        stymie         = true,
        fealty         = true,
        saboteur       = true,
    }

    return xi.combat.action.executeSpellEnfeeblement(caster, target, spell, params)
end

return spellObject
