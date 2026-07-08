-----------------------------------
-- Spell: Reraise 2
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    --duration = 1800
    target:delStatusEffect(xi.effect.RERAISE)
    target:addStatusEffect(xi.effect.RERAISE, { power = 2, duration = 3600, origin = caster }) --reraise 2, 30min duration

    return xi.effect.RERAISE
end

return spellObject
