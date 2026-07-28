-----------------------------------
-- Spell: Paralyga
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
        power          = utils.clamp(15 + (caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)) / 4 , 5, 25),
        duration       = 120,
        tier           = 1,
        magicalElement = xi.element.ICE,
        actorStat      = xi.mod.MND,
        skillType      = xi.skill.ENFEEBLING_MAGIC,
        spellGroup     = xi.magic.spellGroup.WHITE,
        stymie         = true,
        fealty         = true,
        saboteur       = true,
    }

    return xi.combat.action.executeSpellEnfeeblement(caster, target, spell, params)
end

return spellObject
