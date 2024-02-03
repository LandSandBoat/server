-----------------------------------
-- Reactor Cool
-- Gives Undispellable Ice Spikes and Defense Boost
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() > 1 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.MobBuffMove(mob, xi.effect.ICE_SPIKES, math.random(15, 30), 0, 60))
    local effect1 = mob:getStatusEffect(xi.effect.ICE_SPIKES)
    effect1:delEffectFlag(xi.effectFlag.DISPELABLE)
    xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 26, 0, 60)
    local effect2 = mob:getStatusEffect(xi.effect.DEFENSE_BOOST)
    effect2:delEffectFlag(xi.effectFlag.DISPELABLE)

    return xi.effect.ICE_SPIKES
end

return mobskillObject
