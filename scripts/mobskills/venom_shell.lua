-----------------------------------
--  Venom Shell
--
--  Description: Releases a toxic gas from its shell, poisoning targets in an area of effect.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown radial
--  Notes: Poison is about 24/tic. The Nightmare Uragnite uses an enhanced version that also inflicts Plague.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.POISON

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 12, 0, 120))

    return typeEffect
end

return mobskillObject
