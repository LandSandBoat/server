-----------------------------------
-- Mewing Lullaby
-- aoe light based sleep and lowers mob TP to zero
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    -- Apply TP reset on target. (Secondary effect. Cannot miss.)
    target:setTP(0)

    -- Effects table.
    local effectTable =
    {
        [1] = { effectId = xi.effect.SLEEP_I, power = 1, duration = 90, magicalElement = xi.element.LIGHT, actorStat = xi.mod.CHR, bonusMacc = xi.summon.getSummoningSkillOverCap(pet) },
    }

    return xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, {})
end

return abilityObject
