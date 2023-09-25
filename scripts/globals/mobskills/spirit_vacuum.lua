-----------------------------------
-- Spirit Vacuum
--
-- Description: Absorbs TP
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown
-- Notes: Nightmare Worm
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local tpStolen = target:getTP() * 26 / 30 -- stole 2600/3000 TP per capture - 87%
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.TP, tpStolen))

    return tpStolen
end

return mobskillObject
