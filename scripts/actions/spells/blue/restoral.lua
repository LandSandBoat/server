-----------------------------------
-- Spell: Restoral
-- Removes one negative status effect from the caster
-- Spell cost: 21 MP
-- Monster Type: Aquan
-- Spell Type: Magical (Light)
-- Blue Magic Points: 2
-- Stat Bonus: MND+1
-- Level: 76
-- Casting Time: 2 seconds
-- Recast Time: 6 seconds
-- Duration: Instant
-----------------------------------
-- Combos: None
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
