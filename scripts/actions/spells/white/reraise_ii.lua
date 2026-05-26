-----------------------------------
-- Spell: Reraise 2
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    target:addStatusEffect(xi.effect.RERAISE, { power = 2, duration = 3600, tier = 2, origin = caster })

    return xi.effect.RERAISE
end

return spellObject
