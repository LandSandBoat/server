-----------------------------------
-- Wild Ginseng
-- Description: Grants the effects of Haste, Protect, Shell, Regen, and Blink on the caster.
-- Buff potencies:
-- Despite the description, also grants Protect (60 Defense).
-- Regen effect is 30HP/tick and does not scale.
-- It will not overwrite itself and must be canceled before being reapplied.
-- Haste effect is 20% Haste.
-- Shell effect is -?/256 Magic Damage Taken.
-- Blink has three shadows.
-- All buffs have a random duration between approximately 3.5 and 4.5 minutes.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.PROTECT, 60, 0, math.random(utils.minutes(3.5), utils.minutes(4.5)))
    xi.mobskills.mobBuffMove(mob, xi.effect.SHELL, 2000, 0, math.random(utils.minutes(3.5), utils.minutes(4.5)))
    xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, 30, 0, math.random(utils.minutes(3.5), utils.minutes(4.5)))
    xi.mobskills.mobBuffMove(mob, xi.effect.BLINK, 3, 0, math.random(utils.minutes(3.5), utils.minutes(4.5)))
    xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 1000, 0, math.random(utils.minutes(3.5), utils.minutes(4.5)))

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
