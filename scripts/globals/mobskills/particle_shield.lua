---------------------------------------------
-- Particle Shield
--
-- Description: Enhances defense.
-- Type: Magical
-- Notes: Ultima only.
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobhp = mob:getHPP()

    if (mobhp >= 70 or mobhp < 40) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DEFENSE_BOOST

    skill:setMsg(MobBuffMove(mob, typeEffect, 100, 0, 300))
    return typeEffect
end
