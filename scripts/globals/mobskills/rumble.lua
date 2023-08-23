-----------------------------------
-- Rumble
--
-- Description: A disorienting vibration lowers evasion of targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-- Notes:
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local eva = mob:getStat(xi.mod.EVA) * 0.1
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, eva, 0, math.random(45, 120)))

    return xi.effect.EVASION_DOWN
end

return mobskillObject
