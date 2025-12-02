-----------------------------------
-- Self-Destruct (Growing Bomb)
-- Description : Sacrifices user to deal massive fire damage to targets in the area.
-- Self-Destruct is only used by giant bombs that are not notorious monsters (Friar's Lanterns)
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 20' Area of Effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobType.NOTORIOUS) or mob:getHPP() >= 90 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getHP() / 2

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    mob:setHP(0)

    return damage
end

return mobskillObject
