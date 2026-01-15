-----------------------------------
-- Blood Drain
-- Steals an enemy's HP. Ineffective against undead.
-- TODO: Needs 1.5 + dINT calc
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getMainLvl() + 2
    local shadow = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    -- Asanbosam uses a modified blood drain that ignores shadows
    if mob:getPool() == xi.mobPool.ASANBOSAM then
        shadow = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, shadow)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, damage))

    return damage
end

return mobskillObject
