-----------------------------------
-- Ion_Efflux
-- Description: 10'(?) cone  Paralysis, ignores Utsusemi
-- Type: Magical
-- Range: 10 yalms
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local effectTable =
    {
        [1] = { effectId = xi.effect.PARALYSIS, power = 20, duration = 180 }, -- TODO: Capture power.
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
