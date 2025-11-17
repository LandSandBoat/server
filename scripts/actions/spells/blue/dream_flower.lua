-----------------------------------
-- Spell: Dream Flower
-- Puts enemies within area of effect to sleep
-- Spell cost: 68 MP
-- Monster Type: Plantoid
-- Spell Type: Magical (Light)
-- Blue Magic Points: 3
-- Stat Bonus: HP+5, MP+5, CHR+2
-- Level: 87
-- Casting Time: 2.5 seconds
-- Recast Time: 60 seconds
-- Duration: 90-120 seconds
-----------------------------------
-- Combos: Magic Attack Bonus
-----------------------------------
-- Notes: AoE Sleep, also functions as an interrupt.
-- Does NOT overwrite BRD Lullaby, Sleep II, Sleepga II, or itself.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 90
    local resist = applyResistanceEffect(caster, target, spell, { xi.element.LIGHT }, xi.skill.BLUE_MAGIC)

    if resist > 0.125 then
        -- Apply interrupt effect
        target:resetRecasts()

        if target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration * resist) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return xi.effect.SLEEP_I
end

return spellObject
