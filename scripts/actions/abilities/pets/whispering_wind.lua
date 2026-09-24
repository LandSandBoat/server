-----------------------------------
-- Whispering Wind
-- Family: Avatar (Garuda)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    -- TODO: AOE range scales with TP

    local params = {}

    params.primaryMessage = xi.msg.basic.JA_RECOVERS_HP_2
    params.baseHeal       = pet:getMainLvl() * 10 - 190

    return xi.mobskills.mobHealMove(pet, target, petskill, action, params)
end

return abilityObject
