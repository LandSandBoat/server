---------------------------------------------
-- Fossilizing Breath
--
-- Description: Petrifies targets within a fan-shaped area.
-- Type: Breath
-- Ignores Shadows
-- Range: Unknown cone
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
  if (mob:getFamily() == 316) then
    local mobSkin = mob:getModelId()

    if (mobSkin == 1805) then
        return 0
    else
        return 1
    end
  end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PETRIFICATION
    local power = 1

    local duration = 60

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end
