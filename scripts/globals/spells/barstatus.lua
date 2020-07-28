-----------------------------------------
-- Implementation of Bar-status
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")

function calculateBarstatusPower(caster, enhanceSkill)
    local meritBonus = caster:getMerit(tpz.merit.BAR_SPELL_EFFECT)

    if (enhanceSkill == nil or enhanceSkill < 0) then
        enhanceSkill = 0
    end

    -- No known way to determine actual potency.
    return 1 + 0.02 * enhanceSkill + meritBonus
end

function calculateBarstatusDuration(caster, enhanceSkill)
    -- Function call to allow configuration conditional for old duration formulas.
    return 480
end

function applyBarstatus(effectType, caster, target, spell)
    local enhanceSkill = caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
    local mdefBonus = caster:getMerit(tpz.merit.BAR_SPELL_EFFECT) + caster:getMod(tpz.mod.BARSPELL_MDEF_BONUS)

    local power = calculateBarstatusPower(caster, enhanceSkill)
    local duration = calculateBarstatusDuration(caster, enhanceSkill)
    duration = calculateDuration(duration, tpz.skill.ENHANCING_MAGIC, tpz.magic.spellGroup.WHITE, caster, target)

    target:addStatusEffect(effectType, power, 0, duration)
    return effectType
end
