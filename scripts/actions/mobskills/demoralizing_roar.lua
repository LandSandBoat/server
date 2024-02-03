-----------------------------------
-- Demoralizing Roar
-- Description: Inflicts Attack Down (-50%) to players within a 10' area of effect
-- TODO: Verify 'info', duration
-- https://www.bg-wiki.com/ffxi/Locus_Wivre
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 500
    local duration = 60

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, power, 0, duration)
end

return mobskillObject
