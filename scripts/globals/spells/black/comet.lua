-----------------------------------
-- Spell: Comet
-----------------------------------
require("scripts/globals/spells/damage_spell")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- TODO: Code succesive spell use enhancement. Method still undecided.
    if caster:isMob() and caster:getName() == "Promathia" then
        local dmg = ((100 + caster:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF))) * (caster:getStat(xi.mod.INT) + (caster:getMaxSkillLevel(caster:getMainLvl(), xi.job.BLM, xi.skill.ELEMENTAL_MAGIC)) / 6) * 5

        --add in target adjustment
        dmg = xi.magic.adjustForTarget(target, dmg, spell:getElement())
        --add in final adjustments
        dmg = xi.magic.finalMagicAdjustments(caster, target, spell, dmg)
        return dmg
    else
        return xi.spells.damage.useDamageSpell(caster, target, spell)
    end
end

return spellObject
