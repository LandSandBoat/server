-----------------------------------
--  Decayed Filament
--  Zedi, while in Animation form 2 (Bars)
--  Blinkable 1-2 hit, addtional effect poison on hit.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() ~= 2 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 2
    local accmod = 1
    local ftp    = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, 0, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 18, 3, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
