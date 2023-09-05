-----------------------------------
-- Glittering Ruby
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    --randomly give str/dex/vit/agi/int/mnd/chr (+12)
    local effect = math.random()
    local effectid = xi.effect.STR_BOOST
    if effect <= 0.14 then --STR
        effectid = xi.effect.STR_BOOST
    elseif effect <= 0.28 then --DEX
        effectid = xi.effect.DEX_BOOST
    elseif effect <= 0.42 then --VIT
        effectid = xi.effect.VIT_BOOST
    elseif effect <= 0.56 then --AGI
        effectid = xi.effect.AGI_BOOST
    elseif effect <= 0.7 then --INT
        effectid = xi.effect.INT_BOOST
    elseif effect <= 0.84 then --MND
        effectid = xi.effect.MND_BOOST
    else --CHR
        effectid = xi.effect.CHR_BOOST
    end

    local duration = math.min(90 + xi.summon.getSummoningSkillOverCap(pet) * 3, 180)
    local power = 3 + math.floor(summoner:getJobLevel(xi.job.SMN) / 5)
    target:addStatusEffect(effectid, power, 10, duration)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return effectid
end

return abilityObject
