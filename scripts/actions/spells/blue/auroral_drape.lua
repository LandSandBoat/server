-----------------------------------
-- Spell: Auroral Drape
-- Inflicts Silence and Blind on enemies within area of effect
-- Spell cost: 51 MP
-- Monster Type: Luminian
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: INT+3, CHR-2
-- Level: 84
-- Casting Time: 3 seconds
-- Recast Time: 30 seconds
-- Duration: 40-60 seconds
-----------------------------------
-- Combos: Fast Cast
-----------------------------------
-- Notes: AoE Silence + Blind. Blind effect is -60 Accuracy (stronger than Blind II).
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 50  -- 40-60s, using 50s as midpoint
    local resist = applyResistanceEffect(caster, target, spell, { xi.element.WIND }, xi.skill.BLUE_MAGIC)

    if resist > 0.125 then
        local silenceApplied = target:addStatusEffect(xi.effect.SILENCE, 1, 0, duration * resist)
        local blindApplied = target:addStatusEffect(xi.effect.BLINDNESS, 60, 0, duration * resist)

        if silenceApplied or blindApplied then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return xi.effect.SILENCE
end

return spellObject
