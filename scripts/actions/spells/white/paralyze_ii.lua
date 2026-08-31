-----------------------------------
-- Spell: Paralyze II
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        effectId       = xi.effect.PARALYSIS,
        power          = utils.clamp(24 + (caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)) / 4 , 14, 34), -- Values from JP wiki: https://wiki.ffo.jp/html/3453.html
        duration       = 120,
        tier           = 1,
        magicalElement = xi.element.ICE,
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
