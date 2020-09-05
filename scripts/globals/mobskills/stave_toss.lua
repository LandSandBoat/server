---------------------------------------------
--
-- Stave Toss (staff wielding Mamool Ja only!)
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- If animationSub is 1, mob has already lost the staff. If zero, still has staff.
    if mob:AnimationSub() == 1 then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)

    mob:AnimationSub(1) -- Mob loses Staff on using Stave Toss
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    return dmg
end
