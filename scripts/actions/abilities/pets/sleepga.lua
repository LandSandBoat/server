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

    -- Check nullification.
    if
        xi.data.statusEffect.isTargetImmune(target, xi.effect.SLEEP_I, xi.element.DARK) or
        xi.data.statusEffect.isTargetResistant(pet, target, xi.effect.SLEEP_I) or
        xi.data.statusEffect.isEffectNullified(target, xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_I)
    then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.NO_EFFECT)
        end

        return xi.effect.SLEEP_I
    end

    -- Check resist.
    local bonus    = xi.summon.getSummoningSkillOverCap(pet)
    local resist   = xi.combat.magicHitRate.calculateResistRate(pet, target, 0, 0, 0, xi.element.DARK, xi.mod.INT, xi.effect.SLEEP_I, bonus)
    if resist < 0.5 then
        petskill:setMsg(xi.msg.basic.JA_MISS_2) -- resist message
        return xi.effect.SLEEP_I
    end

    -- Apply.
    local duration = math.floor(90 * resist)

    target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration)
    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT_2)
    else
        petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT)
    end

    target:updateEnmity(pet)

    return xi.effect.SLEEP_I
end

return abilityObject
