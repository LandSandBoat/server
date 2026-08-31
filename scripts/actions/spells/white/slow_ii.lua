-----------------------------------
-- Spell: Slow II
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
        power          = utils.clamp(2780 + (caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)) * 226 / 15, 1650, 3910), -- https://wiki.ffo.jp/html/3454.html
        duration       = 180,
        tier           = 7,
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
