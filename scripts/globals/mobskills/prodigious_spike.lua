---------------------------------------------
--  Prodigious Spike
--
--  Description: Deals heavy damage to a target behind the user.
--  Type: Physical
--  2-3 Shadows
--  Range: Back
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    -- Can always use, only if target is behind and not exclusive like spike flail
    if not target:isBehind(mob, 96) then
        return 1
    end

    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 4
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return dmg
end

return mobskill_object
