-----------------------------------
-- Reactor Cool
-- Gives Undispellable Ice Spikes and Defense Boost
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ICE_SPIKES, math.random(15, 30), 0, 120))

    local effect1 = mob:getStatusEffect(xi.effect.ICE_SPIKES)
    if effect1 then
        effect1:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 25, 0, 120)

    local effect2 = mob:getStatusEffect(xi.effect.DEFENSE_BOOST)
    if effect2 then
        effect2:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    return xi.effect.ICE_SPIKES
end

return mobskillObject
