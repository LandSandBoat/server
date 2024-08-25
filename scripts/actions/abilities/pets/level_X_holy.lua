-----------------------------------
-- Level X Holy
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)
    local damage            = 0
    local holyRollOneAnimID = 164
    local primaryTargetID   = action:getPrimaryTargetID()

    -- If primary target, roll for power by setting random animation.
    -- We do this so the animation is random, but only rolled for once. (AKA: The same for all targets)
    if primaryTargetID == target:getID() then
        action:setAnimation(primaryTargetID, holyRollOneAnimID + math.random(0, 5))
    else
        local animationId = action:getAnimation(primaryTargetID)
        if animationId then
            action:setAnimation(target:getID(), animationId)
        end
    end

    local power = action:getAnimation(target:getID()) - 163

    -- Only have an effect if target's level is divisible by die roll
    if target:getMainLvl() % power == 0 then
        damage = math.floor(pet:getMainLvl() * power + (pet:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)) * 1.5)

        damage = xi.mobskills.mobMagicalMove(pet, target, petskill, damage, xi.element.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 10)
        damage = xi.mobskills.mobAddBonuses(pet, target, damage, xi.element.LIGHT, petskill)
        damage = xi.summon.avatarFinalAdjustments(damage, pet, petskill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, 1)

        -- TODO: Magic burst?

        target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.element.LIGHT)
        target:updateEnmityFromDamage(pet, damage)
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    end

    return damage
end

return abilityObject
