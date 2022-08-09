-----------------------------------
-- Self-Destruct
-- Bomb Cluster Self Destruct - 2 Bombs up
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if mob:getHPP() > 60 or mob:getAnimationSub() ~= 5 then
        return 1
    end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local bombTossHPP = skill:getMobHPP() / 100

    -- Razon - ENM: Fire in the Sky
    if mob:getHPP() <= 33 and mob:getPool() == 3333 then
        bombTossHPP = 0
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*18*bombTossHPP, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setAnimationSub(6)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskill_object
