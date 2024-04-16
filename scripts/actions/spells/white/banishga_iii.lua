-----------------------------------
-- Spell: Banishga III
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:isUndead() then
        local merits   = caster:getMerit(xi.merit.BANISH_EFFECT) - 2
        local duration = 45 + merits
        local gearModifier = caster:getMod(xi.mod.BANISH_POTENCY)
        target:addStatusEffectEx(xi.effect.BANISH_SDT_DEBUFF, 0, 3, 0, duration, 0, gearModifier, 0, 0)
    end
    
    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spellObject
