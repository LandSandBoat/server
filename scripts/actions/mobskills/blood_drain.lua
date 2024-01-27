-----------------------------------
-- Blood Drain
-- Steals an enemy's HP. Ineffective against undead.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local shadow = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    -- Asanbosam (pool id 256) uses a modified blood drain that ignores shadows
    if mob:getPool() == 256 then
        shadow = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, shadow)
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end

return mobskillObject
