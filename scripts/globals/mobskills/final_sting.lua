---------------------------------------------
--  Final Sting
--
--  Description: Deals damage proportional to HP. Reduces HP to 1 after use. Damage varies with TP.
--  Type: Physical (Slashing)
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    local param = skill:getParam()
    if (param == 0) then
        param = 50
    end

    if (mob:getHPP() <= param) then
        return 0
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local mobHP = mob:getHP()
    local hpMod = skill:getMobHPP() / 100
    dmgmod = dmgmod + hpMod * 14 + math.random(2, 6)

    if (mob:isMobType(MOBTYPE_NOTORIOUS)) then
        dmgmod = dmgmod * 5
    end

    mob:setHP(0)

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg
end
