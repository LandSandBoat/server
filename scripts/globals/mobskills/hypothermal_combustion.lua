-----------------------------------
-- Hypothermal Combustion
-- Self-destructs, releasing ice at nearby targets.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Notes: Damage is based on remaining HP
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:isMobType(MOBTYPE_NOTORIOUS)) then
        return 1
    end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local BOMB_TOSS_HPP = skill:getMobHPP() / 100

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*20*BOMB_TOSS_HPP, tpz.magic.ele.ICE, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ICE)
    return dmg
end

return mobskill_object
