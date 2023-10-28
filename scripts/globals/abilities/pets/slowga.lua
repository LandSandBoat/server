-----------------------------------
-- Slowga
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    if target:hasImmunity(xi.immunity.SLOW) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    end

    if target:hasStatusEffect(xi.effect.HASTE) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return xi.effect.SLOW
    end

    local bonusTime = utils.clamp(xi.summon.getSummoningSkillOverCap(pet) * 3, 0, 90)-- 3 seconds / skill | Duration is capped at 180 total
    local duration = 90 + bonusTime

    local dMND = pet:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

    local params = {}
    params.dStat = dMND
    params.element = xi.magic.ele.EARTH
    params.effect = xi.effect.SLOW
    params.duration = duration
    params.power = 3000
    params.tick = 0
    params.tier = 1

    if not xi.magic.differentEffect(summoner, target, skill, params) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return params.effect
    end

    local resist = xi.magic.applyAbilityResistance(pet, target, params)

    if resist >= 0.5 then --Do it!
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB)
        -- only increment the resbuild if successful (not on a no effect)
        xi.magic.incrementBuildDuration(target, params.effect, summoner)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return params.effect
end

return abilityObject
