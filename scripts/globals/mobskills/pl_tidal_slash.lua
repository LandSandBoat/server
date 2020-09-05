---------------------------------------------
-- Tidal Slash
--
-- Description: Deals Water damage in a threefold
-- attack to targets in a fan-shaped area of effect.
-- Type: Physical?
-- Utsusemi/Blink absorb: 2-3 shadows
-- Range: Melee?
-- Notes: Used only by Merrows equipped with a spear.
-- If they lost their spear, they'll use Hysteric Barrage instead.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobSkin = mob:getModelId()

    if (mobSkin == 1643) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg
end
