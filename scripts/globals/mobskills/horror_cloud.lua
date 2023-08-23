-----------------------------------
-- Horror Cloud
--
-- Description: A debilitating cloud slows the attack speed of a single target.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-- Notes: Can be overwritten and blocked by Haste.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local noResist = 1

    -- 2 minute unresisted duration.
    if target:hasStatusEffect(xi.effect.HASTE) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 5000, 0, 120, 0, 0, noResist))
    end

    return xi.effect.SLOW
end

return mobskillObject
