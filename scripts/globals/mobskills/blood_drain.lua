---------------------------------------------
-- Blood Drain
-- Steals an enemy's HP. Ineffective against undead.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2, tpz.magic.ele.DARK, dmgmod, TP_MAB_BONUS, 1)

    if mob:getPool() == 256 then -- Asanbosam (pool id 256) uses a modified blood drain that ignores shadows
        local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    else
        local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_1_SHADOW)
    end
    skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_HP, dmg))
    return dmg
end
