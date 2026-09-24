-----------------------------------
-- Eerie Eye
-- Family: Avatar (Cait Sith)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

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

    -- Effects table.
    local effectTable =
    {
        [1] = { effectId = xi.effect.SILENCE, power = 1, duration = 30, magicalElement = xi.element.LIGHT, actorStat = xi.mod.CHR, bonusMacc = xi.summon.getSummoningSkillOverCap(pet) },
        [2] = { effectId = xi.effect.AMNESIA, power = 1, duration = 15, magicalElement = xi.element.FIRE,  actorStat = xi.mod.CHR, bonusMacc = xi.summon.getSummoningSkillOverCap(pet) },
    }

    return xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, messageParams)
end

return abilityObject
