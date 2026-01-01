-----------------------------------
-- Self-Destruct
-- Description : Sacrifices user to deal fire damage to targets in the area.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getHP() / 3

    -- Bomb Princes, Princesses, and Bastards do 1 for 1 damage of their HP on self-destruct.  It's also breath damage, which hasn't been changed.
    -- Self-Destruct will need more research as it seems to have no variance on BQ's pet, but not so for normal bombs.
    if
        mob:getPool() == xi.mobPools.BOMB_PRINCE or
        mob:getPool() == xi.mobPools.BOMB_PRINCESS or
        mob:getPool() == xi.mobPools.BOMB_BASTARD
    then
        damage = mob:getHP()
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    mob:setHP(0)
end

return mobskillObject
