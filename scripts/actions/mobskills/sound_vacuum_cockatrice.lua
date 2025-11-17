-----------------------------------
-- Sound Vacuum
-- Description: Silences opponents in a fan-shaped area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10.0 Cone
-- TODO: Once Dreamworld Dynamis is implemented, add a new lua for sound_vacuum_cockatrice_nightmare to change SILENCE to MUTE for Nightmare Cockatrice
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 120))

    return xi.effect.SILENCE
end

return mobskillObject
