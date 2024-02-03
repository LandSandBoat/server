-----------------------------------
-- Discharger
-- Description: Places a magic barrier and shock spikes.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Used only by Omega
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_SHIELD, 1, 0, 60))
    xi.mobskills.mobBuffMove(mob, xi.effect.SHOCK_SPIKES, 25, 0, 60)

    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
