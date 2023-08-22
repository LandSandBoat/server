-----------------------------------
--  Toxic Spit
--
--  Description: Spews a toxic glob at a single target. Effect: Poison
--  Type: Magical Water
--  Utsusemi/Blink absorb: Ignores shadows
--  Notes: Additional effect can be removed with Poisona.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = mob:getMainLvl() / 5 + 3

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 180)
end

return mobskillObject
