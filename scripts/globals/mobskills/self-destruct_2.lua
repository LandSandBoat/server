-----------------------------------
-- Self-Destruct
-- Bomb Cluster Self Destruct - 2 Bombs up
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getHPP() > 32 or mob:getAnimationSub() ~= 1 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = skill:getMobHP() / 6

    if skill:getID() == 1855 then -- Nightmare Cluster - increased damage
        damage = skill:getMobHP() / 2
    end

    -- Razon - ENM: Fire in the Sky
    if mob:getHPP() <= 33 and mob:getPool() == 3333 then
        damage = 0
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1, 0, 1, 1.1, 1.2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setAnimationSub(2)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
