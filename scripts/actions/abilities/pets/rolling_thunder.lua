-----------------------------------
-- Rolling Thunder
-- Family: Avatar (Ramuh)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local baseDuration = 120
    local bonusTime    = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration     = baseDuration + bonusTime

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local magicskill = xi.data.skillLevel.getSkillCap(target:getMainLvl(), xi.skillRank.A_PLUS)
    local potency    = 3 + 6 * magicskill / 100

    if magicskill > 200 then
        potency = 5 + 5 * magicskill / 100
    end

    xi.mobskills.mobBuffMove(target, xi.effect.ENTHUNDER, potency, 0, duration)

    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT_2)
    else
        petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT)
    end

    return xi.effect.ENTHUNDER
end

return abilityObject
