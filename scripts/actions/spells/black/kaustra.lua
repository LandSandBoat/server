-----------------------------------
-- Spell: Kaustra
-- Consumes 20% of your maximum MP.
-- Relentless dark damage slowly devours an enemy.
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if caster:hasStatusEffect(xi.effect.TABULA_RASA) then
        return 0
    end

    return 1
end

spellObject.onSpellCast = function(caster, target, spell)
    local damage = xi.spells.damage.useDamageSpell(caster, target, spell) -- Gets nuke power and sets messages.

    -- Can't apply if absorbed, nullified or 0 power.
    if damage >= 4 then
        local casterSkill = utils.clamp(caster:getSkillLevel(xi.skill.DARK_MAGIC), 0, 500)
        local power       = math.floor(damage / 4)
        local duration    = math.floor(3 * (1 + casterSkill / 11))

        target:addStatusEffect(xi.effect.KAUSTRA, power, 3, duration)
    end

    return damage
end

return spellObject
