-----------------------------------
-- Blood Drain
-- Steals an enemy's HP. Ineffective against undead.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 2
    local shadow = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    -- Asanbosam (pool id 256) uses a modified blood drain that ignores shadows
    if mob:getPool() == 256 then
        shadow = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, shadow)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, damage))

    return damage
end

return mobskillObject
