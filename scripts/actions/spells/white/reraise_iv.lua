-----------------------------------
-- Spell: Reraise 4
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    --duration = 1800
    target:delStatusEffect(xi.effect.RERAISE)
    target:addStatusEffect(xi.effect.RERAISE, { power = 4, duration = 3600, origin = caster }) --reraise 3, 30min duration

    return xi.effect.RERAISE
end

return spellObject
