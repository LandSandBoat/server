-----------------------------------
-- Drainkiss
-- Deals dark damage to a single target. Additional effect: TP Drain
-- Type: Magical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local tpStolen = target:getTP() / 2 -- 50% of targets TP according to JP Wikis
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.TP, tpStolen))

    return tpStolen
end

return mobskillObject
