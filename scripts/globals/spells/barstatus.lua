-----------------------------------
-- Implementation of Bar-status
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------

local function calculateBarstatusPower(caster, enhanceSkill)
    local meritBonus = caster:getMerit(xi.merit.BAR_SPELL_EFFECT)

    if (enhanceSkill == nil or enhanceSkill < 0) then
        enhanceSkill = 0
    end

    -- No known way to determine actual potency.
    return 1 + 0.02 * enhanceSkill + meritBonus
end

local function calculateBarstatusDuration(caster, enhanceSkill)
    -- Function call to allow configuration conditional for old duration formulas.
    return 480
end

function applyBarstatus(effectType, caster, target, spell)
    local enhanceSkill = caster:getSkillLevel(xi.skill.ENHANCING_MAGIC)
    local mdefBonus = caster:getMerit(xi.merit.BAR_SPELL_EFFECT) + caster:getMod(xi.mod.BARSPELL_MDEF_BONUS)

    local power = calculateBarstatusPower(caster, enhanceSkill)
    local duration = calculateBarstatusDuration(caster, enhanceSkill)
    duration = calculateDuration(duration, xi.skill.ENHANCING_MAGIC, xi.magic.spellGroup.WHITE, caster, target)

    target:addStatusEffect(effectType, power, 0, duration)
    return effectType
end
