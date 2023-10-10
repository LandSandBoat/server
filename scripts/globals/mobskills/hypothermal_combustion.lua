-----------------------------------
-- Hypothermal Combustion
-- Self-destructs, releasing ice at nearby targets.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Notes: Damage is based on remaining HP
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = skill:getMobHP() / 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.ICE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    mob:setLocalVar("gameover", 1)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end

return mobskillObject
