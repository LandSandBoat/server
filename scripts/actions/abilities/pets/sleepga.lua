-----------------------------------
-- Sleepga
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local duration = 90
    local dINT = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local bonus = xi.summon.getSummoningSkillOverCap(pet)
    local resm = xi.mobskills.applyPlayerResistance(pet, -1, target, dINT, bonus, xi.element.ICE)

    if resm < 0.5 then
        petskill:setMsg(xi.msg.basic.JA_MISS_2) -- resist message
        return xi.effect.SLEEP_I
    end

    duration = duration * resm

    if
        target:hasImmunity(xi.immunity.DARK_SLEEP) or
        target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY)
    then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.NO_EFFECT)
        end
    else
        target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration)
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT)
        end
    end

    target:updateEnmity(pet)

    return xi.effect.SLEEP_I
end

return abilityObject
