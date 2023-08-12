-----------------------------------
-- Reactor Cool
-- Gives Undispellable Ice Spikes and Defense Boost
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() > 1 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect  = xi.effect.ICE_SPIKES
    local typeEffect2 = xi.effect.DEFENSE_BOOST

    skill:setMsg(xi.mobskills.MobBuffMove(mob, typeEffect, math.random(15, 30), 0, 60))
    local effect1 = mob:getStatusEffect(xi.effect.ICE_SPIKES)
    effect1:unsetFlag(xi.effectFlag.DISPELABLE)
    xi.mobskills.mobBuffMove(mob, typeEffect2, 26, 0, 60)
    local effect2 = mob:getStatusEffect(xi.effect.DEFENSE_BOOST)
    effect2:unsetFlag(xi.effectFlag.DISPELABLE)

    return typeEffect
end

return mobskillObject
