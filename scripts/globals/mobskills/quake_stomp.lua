-----------------------------------
-- Quake Stomp
--
-- Description: Stomps the ground to boost next attack.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes:
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
  if (mob:getFamily() == 91) then
    local mobSkin = mob:getModelId()

    if (mobSkin == 1680) then
        return 0
    else
        return 1
    end
  end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local power = 1
    local duration = 60

    local typeEffect = xi.effect.BOOST

    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end

return mobskill_object
