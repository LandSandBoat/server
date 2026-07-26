-----------------------------------
-- Eerie Eye
-- silence + amnesia
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    -- Effects table.
    local effectTable =
    {
        [1] = { effectId = xi.effect.SILENCE, power = 1, duration = 30, magicalElement = xi.element.LIGHT, actorStat = xi.mod.CHR, bonusMacc = xi.summon.getSummoningSkillOverCap(pet) },
        [2] = { effectId = xi.effect.AMNESIA, power = 1, duration = 15, magicalElement = xi.element.FIRE,  actorStat = xi.mod.CHR, bonusMacc = xi.summon.getSummoningSkillOverCap(pet) },
    }

    return xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, {})
end

return abilityObject
