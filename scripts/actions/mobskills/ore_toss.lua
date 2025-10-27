-----------------------------------
--  Ore Toss
--
--  Description: Deals high damage in a ranged attack.
--  Type: Ranged
--  Utsusemi/Blink absorb: Yes
--  Range: Unknown range
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 2
    local info    = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    -- Distance-based damage scaling: 1x at 1 yalm, 3x at 10 yalms
    -- TODO: Determine max distance of skill
    local distance           = mob:checkDistance(target)
    local distanceMultiplier = utils.clamp(1 + (distance - 1) * 2 / 9, 1, 3)

    dmg = math.floor(dmg * distanceMultiplier)

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)

    return dmg
end

return mobskillObject
