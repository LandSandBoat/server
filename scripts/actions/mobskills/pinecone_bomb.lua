-----------------------------------
--  Pinecone Bomb
--  Description: Single target damage with sleep.
--  Notes: When used by Cemetery Cherry, and leafless Jidra: Doesn't cause sleep but does ~600 damage
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 1
    if mob:getPool() == 671 or mob:getPool() == 1346 then -- Cemetery Cherry and leafless Jidra
        ftp = 3
    else
        ftp = 2.3
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    if mob:getPool() ~= 671 and mob:getPool() ~= 1346 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLEEP_I, 1, 0, 30)
    end

    return dmg
end

return mobskillObject
