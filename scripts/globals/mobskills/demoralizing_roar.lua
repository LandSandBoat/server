-----------------------------------
-- Demoralizing Roar
-- Description: Inflicts Attack Down (-50%) to players within a 10' area of effect
-- TODO: Verify 'info', duration
-- https://www.bg-wiki.com/ffxi/Locus_Wivre
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.ATTACK_DOWN
    local power = 500
    local duration = 60

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration)
end

return mobskillObject
