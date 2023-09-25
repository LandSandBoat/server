---------------------------------------------------
-- Tenzed Ranged Attack Alt
-- Only Used when in Bow Mode
-- Deals a ranged attack to a single target.
---------------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addTP(20)
        mob:addTP(80)
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    skill:setMsg(352) -- fixes incorrect messages on ranged attacks
    return dmg
end

return mobskillObject
