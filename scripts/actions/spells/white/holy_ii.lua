-----------------------------------
-- Spell: Holy II
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if
        caster:hasStatusEffect(xi.effect.DIVINE_EMBLEM) and
        target:isUndead()
    then
        target:addStatusEffect(xi.effect.AMNESIA, { power = 1, duration = math.random(20, 25), origin = caster })
    end

    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spellObject
