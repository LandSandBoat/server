---------------------------------------------------
-- Moonlit Charge
-- Fenrir inflicts Blindness along with a single attack (knockback) to target.
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 4

    local totaldamage = 0
    local damage = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3)
    totaldamage = MobFinalAdjustments(damage.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, numhits)
    target:addStatusEffect(tpz.effect.BLINDNESS, 20, 0, 30)
    target:takeDamage(totaldamage, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    return totaldamage

end
