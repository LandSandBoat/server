-----------------------------------
-- Spell: Reraise
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    --duration = 1800
    target:addStatusEffect(xi.effect.RERAISE, { power = 1, duration = 3600, origin = caster }) --reraise 1, 30min duration

    return xi.effect.RERAISE
end

return spellObject
