---------------------------------------------
-- Nightmare
-- AOE Sleep with Bio dot
---------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/magic")
require("scripts/globals/summon")
---------------------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill)
    local typeEffect = xi.effect.SLEEP_I
    local power = 20
    local tick = 3
    local subEffect = xi.effect.BIO
    local subPower = 2 -- 2 HP/tick drain

    local skillOverCap = utils.clamp(xi.summon.getSummoningSkillOverCap(pet) * 2, 0, 120)-- 2 seconds / skill | Duration is capped at 180 total
    local duration = 60 + skillOverCap -- Unresisted, 20 ticks at 21 hp/tick = 420hp per target
    local dINT = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local resm = xi.mobskills.applyPlayerResistance(pet, -1, target, dINT, 0, xi.magic.ele.DARK)
    if resm < 0.5 then
        skill:setMsg(xi.msg.basic.JA_MISS_2) -- resist message
        return xi.effect.SLEEP_I
    end

    duration = duration * resm
    if
        target:hasImmunity(1) or
        target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY)
    then
        --No effect
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(pet, target, typeEffect, power, tick, duration, subEffect, subPower))
    end

    return typeEffect
end

return abilityObject
