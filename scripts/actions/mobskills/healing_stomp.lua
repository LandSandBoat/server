-----------------------------------
-- Healing Stomp
--
-- Description: Stomps the ground to apply regeneration.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Only used by notorious monsters.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, 25, 3, 180))

    return xi.effect.REGEN
end

return mobskillObject
