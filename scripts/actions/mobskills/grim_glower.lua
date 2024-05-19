-----------------------------------
--  Grim Glower
--
--  Description: Gaze petrify for 15 seconds. Glower stays active for ~30~45 seconds.
--  Note: the skill itself is only an animation.
--      The mob then has an aura-like gaze while the animation sub is active. This is handled in scripts\mixins\families\peiste.lua
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
