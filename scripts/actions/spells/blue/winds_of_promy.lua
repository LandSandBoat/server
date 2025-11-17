-----------------------------------
-- Spell: Winds of Promy
-- Removes one negative status effect from party members within area of effect
-- Spell cost: 52 MP
-- Monster Type: Elementals
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: MND+3
-- Level: 89
-- Casting Time: 2 seconds
-- Recast Time: 10 seconds
-- Duration: Instant
-----------------------------------
-- Combos: Auto Refresh
-----------------------------------
-- Notes: AoE version of Erase
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local effect = target:eraseStatusEffect()

    if effect == xi.effect.NONE then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_ERASE)
    end

    return effect
end

return spellObject
