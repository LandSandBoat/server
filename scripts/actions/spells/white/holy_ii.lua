-----------------------------------
-- Spell: Holy II
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if
        caster:hasStatusEffect(xi.effect.DIVINE_EMBLEM) and
        target:isUndead()
    then
        target:addStatusEffect(xi.effect.AMNESIA, 1, 0, math.random(20, 25))
    end

    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spellObject
