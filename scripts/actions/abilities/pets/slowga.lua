-----------------------------------
-- Slowga
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local duration = 180 + summoner:getMod(xi.mod.SUMMONING)
    if duration > 350 then
        duration = 350
    end

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    if target:addStatusEffect(xi.effect.SLOW, { power = 3000, duration = duration, origin = pet, tier = 3 }) then
        petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT_2)
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    end

    -- TODO: Verify enmity gain total
    target:addEnmity(pet, 1, 60)

    return xi.effect.SLOW
end

return abilityObject
