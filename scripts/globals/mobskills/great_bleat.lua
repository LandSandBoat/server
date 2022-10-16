-----------------------------------
-- Great Bleat
--
-- Description: Lowers maximum HP of targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-- Notes:
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.MAX_HP_DOWN

    if mob:getPool() == 230 then -- Aries
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 75, 0, 90)) -- 75% HP Reduction for 90s
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 30, 0, 60))
    end

    return typeEffect
end

return mobskillObject
