-----------------------------------
-- Reactor Cool
-- Gives Undispellable Ice Spikes and Defense Boost
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.ICE_SPIKES
    local typeEffect2 = xi.effect.DEFENSE_BOOST
    local randy = math.random(15, 30)

    -- Todo: check message behavior, this double setMsg() looks wrong
    skill:setMsg(MobBuffMove(mob, typeEffect, randy, 0, 60))
    local effect1 = mob:getStatusEffect(xi.effect.ICE_SPIKES)
    effect1:unsetFlag(xi.effectFlag.DISPELABLE)
    skill:setMsg(MobBuffMove(mob, typeEffect2, 26, 0, 60))
    local effect2 = mob:getStatusEffect(xi.effect.DEFENSE_BOOST)
    effect2:unsetFlag(xi.effectFlag.DISPELABLE)

    return typeEffect
end

return mobskill_object
