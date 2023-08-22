-----------------------------------
-- Sound Vacuum
--
-- Description: Silences opponents in a fan-shaped area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown cone
-- Notes: Worm version is single target rather than conical (except for Nightmare Worm). The Nightmare Cockatrice inflicts Mute with this ability.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 90

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, duration))

    return xi.effect.SILENCE
end

return mobskillObject
