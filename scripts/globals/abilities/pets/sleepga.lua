-----------------------------------
-- Sleepga
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/magic")
require("scripts/globals/summon")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    if
        target:hasImmunity(xi.immunity.SLEEP) or
        target:hasImmunity(xi.immunity.DARK_SLEEP) or
        target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY)
    then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return
    end

    local dINT = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local params = {}
    params.dStat = dINT
    params.element = xi.magic.ele.DARK
    params.effect = xi.effect.SLEEP_I
    params.duration = 90
    params.power = 1
    params.tick = 0
    params.tier = 1
    -- sleepga macc is impacted by summoning skill
    params.maccBonus = xi.summon.getSummoningSkillOverCap(pet)

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
