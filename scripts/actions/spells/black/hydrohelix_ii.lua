-----------------------------------
-- Spell: Hydrohelix II
-- Deals water damage that gradually reduces a target's HP.
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local damage = xi.spells.damage.useDamageSpell(caster, target, spell) -- Gets nuke power and sets messages.

    -- Can't apply if absorbed or nullified.
    if damage > 0 then
        local power    = utils.clamp(damage, 0, 9999)
        local duration = xi.spells.enfeebling.calculateDuration(caster, target, spell:getID(), xi.effect.HELIX, xi.skill.ELEMENTAL_MAGIC)

        target:addStatusEffect(xi.effect.HELIX, power, 10, duration, 0, 0, 2)
    end

    return damage
end

return spellObject
