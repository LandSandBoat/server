-----------------------------------
-- Tidal Roar
-- Family: Avatar (Leviathan)
-- https://wiki.ffo.jp/html/21081.html
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local baseDuration = 60 -- TODO: Capture baseDuration
    local bonusTime    = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration     = baseDuration + bonusTime

    local effectTable =
    {
        -- TODO: Capture Tier
        -- TODO: Research how half resists are handled
        [1] = { effectId = xi.effect.ATTACK_DOWN, power = 25, origin = pet, duration = duration, tier = 1, magicalElement = xi.element.WATER },
    }

    local messageParams =
    {
        messageBypass          = false,
        messageCantGain        = xi.msg.basic.JA_NO_EFFECT,
        messageIsImmune        = xi.msg.basic.JA_MISS,
        messageIsTraitResisted = xi.msg.basic.JA_MISS,
        messageIsIncompatible  = xi.msg.basic.JA_MISS,
        messageIsResisted      = xi.msg.basic.JA_MISS,
        messageIsNotSuccessful = xi.msg.basic.JA_MISS,
        messageIsSuccessful    = xi.msg.basic.JA_ENFEEB_IS,
    }

    return xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, messageParams )
end

return abilityObject
