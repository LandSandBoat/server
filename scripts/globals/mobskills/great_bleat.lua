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
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getPool() == 230 then -- Aries
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 75, 0, 90)) -- 75% HP Reduction for 90s
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 75, 0, 60)) -- Regular mobs are also 75%
    end

    return xi.effect.MAX_HP_DOWN
end

return mobskillObject
