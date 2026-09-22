-----------------------------------
-- Sleepga
-- Family: Avatar (Shiva)
-- Note: Ability range was increased in Sept. 6, 2016 update:
-- https://wiki.ffo.jp/html/35741.html
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local duration = 90

    local effectTable =
    {
        -- Does not overwrite Sleep I or Sleep II.
        -- Does not overwrite self.
        [1] = { effectId = xi.effect.SLEEP_I, power = 1, origin = pet, duration = duration, tier = 1, magicalElement = xi.element.DARK, bonusMacc = xi.summon.getSummoningSkillOverCap(pet) },
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
