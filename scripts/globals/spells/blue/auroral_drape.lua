-----------------------------------
-- Spell: Auroral Drape
-- Silences and blinds enemies within range.
-- Spell cost: 51 MP
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: INT+3 CHR-2
-- Level: 84
-- Casting Time: 4 seconds
-- Recast Time: 60 seconds
-- Combos: Clear Mind
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)

    local duration = 60
    local silence = applyResistanceEffect(caster, target, spell, {
        diff = nil,
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        bonus = 0,
        effect = xi.effect.SILENCE
    })

    if (silence > 0.5) then -- Do it!
        if (target:addStatusEffect(xi.effect.SILENCE, 1, 0, duration)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    local blind = applyResistanceEffect(caster, target, spell, {
        diff = nil,
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        bonus = 0,
        effect = xi.effect.BLINDNESS
    })

    if (blind > 0.5) then -- Do it!
        if (target:addStatusEffect(xi.effect.BLINDNESS, 60, 0, duration)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return xi.effect.SILENCE
end

return spell_object