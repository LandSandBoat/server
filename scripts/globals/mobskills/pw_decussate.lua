---------------------------------------------
-- Decussate
--
-- Description: Performs a cross attack on nearby targets.
-- Type: Magical
-- Utsusemi/Blink absorb: 2-3 shadows?
-- Range: Less than or equal to 10.0
-- Notes: Only used by Gulool Ja Ja when below 35% health.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobSkin = mob:getModelId()

    if (mobSkin == 1863) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1.2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.EARTH, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.EARTH, math.random(2, 3)*info.hitslanded)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
    return dmg
end
