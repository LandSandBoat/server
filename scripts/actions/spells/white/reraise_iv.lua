-----------------------------------
-- Spell: Reraise 4
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    target:addStatusEffect(xi.effect.RERAISE, { power = 4, duration = 3600, tier = 4, origin = caster })

    return xi.effect.RERAISE
end

return spellObject
