-----------------------------------
-- Spell: Mortal Ray
-- Inflicts Doom on a single target
-- Spell cost: 44 MP
-- Monster Type: Undead
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 2
-- Stat Bonus: INT+3, MND+3
-- Level: 91
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 10 seconds (countdown to death)
-----------------------------------
-- Combos: Dual Wield
-----------------------------------
-- Notes: High-priority enfeeble. Land rate based on Magic Accuracy.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Doom: 10 second countdown to death
    local duration = 10
    local resist = applyResistanceEffect(caster, target, spell, { xi.element.DARK }, xi.skill.BLUE_MAGIC)

    if resist > 0.125 then
        if target:addStatusEffect(xi.effect.DOOM, 10, 3, duration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return xi.effect.DOOM
end

return spellObject
