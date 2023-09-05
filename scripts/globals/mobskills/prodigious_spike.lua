---------------------------------------------
--  Prodigious Spike
--
--  Description: Deals heavy damage to a target behind the user.
--  Type: Physical
--  2-3 Shadows
--  Range: Back
---------------------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Can always use, only if target is behind and not exclusive like spike flail
    if not target:isBehind(mob, 96) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end

return mobskillObject
