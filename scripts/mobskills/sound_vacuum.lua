-----------------------------------
-- Sound Vacuum
--
-- Description: Silences opponents in a fan-shaped area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown cone
-- Notes: Worm version is single target rather than conical (except for Nightmare Worm). The Nightmare Cockatrice inflicts Mute with this ability.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SILENCE

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 45))

    return typeEffect
end

return mobskillObject
