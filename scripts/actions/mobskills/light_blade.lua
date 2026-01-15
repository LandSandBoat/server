-----------------------------------
--  Light Blade
--  Description: Deals very high physical damage to a single player.
--  Type: Ranged
--  Damage decreases the farther away the target is from him.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 6
    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.SLASHING, info.hitslanded)

    local distance = mob:checkDistance(target)
    distance = utils.clamp(distance, 0, 40)
    dmg = dmg * ((50 - distance) / 50)

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
