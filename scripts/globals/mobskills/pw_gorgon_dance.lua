---------------------------------------------
-- Gorgon Dance
--
-- Description: Petrifies all targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial?
-- Notes: Used only by Medusa. Starts using it at 25%.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)

    local mobhp = mob:getHPP()
    if (mobhp <= 25) then -- She's under 25%, it's okay to use this.
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PETRIFICATION
    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, math.random(60, 180)))
    return typeEffect
end
