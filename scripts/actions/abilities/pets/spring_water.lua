-----------------------------------
-- Spring Water
-- Family: Avatar (Leviathan)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    -- TODO: Ability range scales with TP.

    local removableEffects =
    {
        xi.effect.BLINDNESS,
        xi.effect.DISEASE,
        xi.effect.PARALYSIS,
        xi.effect.PETRIFICATION,
        xi.effect.POISON,
        xi.effect.SILENCE,
        -- TODO: JPWiki mentions that Spring Water can remove Mute inflicted by Promathia. Need captures.
        -- Mute inflicted from Eight of Cups mob could not be removed by this skill.
    }

    local activeEffects = {}

    -- Fetch list of removable effects currently on target
    for _, effectId in ipairs(removableEffects) do
        if target:getStatusEffect(effectId) then
            table.insert(activeEffects, effectId)
        end
    end

    -- Remove one removable effect from the target, chosen at random
    if #activeEffects > 0 then
        activeEffects = utils.shuffle(activeEffects)

        target:delStatusEffect(activeEffects[1])
    end

    local params = {}

    params.baseHeal       = pet:getMainLvl() * 8 - 152
    params.primaryMessage = xi.msg.basic.JA_RECOVERS_HP_2

    return xi.mobskills.mobHealMove(pet, target, petskill, action, params)
end

return abilityObject
