-----------------------------------
-- Mewing Lullaby
-- Family: Avatar (Cait Sith)
-- Description: AOE light based sleep and lowers mob TP to zero
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    -- Apply TP reset on target. (Secondary effect. Cannot miss.)
    target:setTP(0)

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
        -- TODO: Get a capture of retail duration. JPWiki says 30s.
        -- TODO: See if duration scales after 300 summoning skill.
        [1] = { effectId = xi.effect.SLEEP_I, power = 1, duration = 30, magicalElement = xi.element.LIGHT, actorStat = xi.mod.CHR, bonusMacc = xi.summon.getSummoningSkillOverCap(pet) },
    }

    return xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, messageParams)
end

return abilityObject
