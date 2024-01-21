-----------------------------------
-- Slowga
-----------------------------------
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

    if target:addStatusEffect(xi.effect.SLOW, 3000, 0, duration) then
        petskill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    else
        petskill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    -- TODO: Verify enmity gain total
    target:addEnmity(pet, 1, 60)

    return xi.effect.SLOW
end

return abilityObject
