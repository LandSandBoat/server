-----------------------------------
-- Level X Holy
-- Family: Cait sith (Player Pet)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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

    local params = {}

    params.baseDamage       = pet:getMainLvl()
    params.fTP              = { power, power, power }
    -- TODO: wSCs?
    params.element          = xi.element.LIGHT
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.LIGHT
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1 -- TODO: Capture shadowBehavior
    params.dStatMultiplier  = 1.5
    params.dStatAttackerMod = xi.mod.MND
    params.dStatDefenderMod = xi.mod.MND
    params.canMagicBurst    = true
    params.primaryMessage   = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobMagicalMove(pet, target, petskill, action, params)

    -- Only have an effect if target's level is divisible by die roll
    if target:getMainLvl() % power == 0 then
        if xi.mobskills.processDamage(pet, target, petskill, action, info) then
            target:takeDamage(info.damage, pet, info.attackType, info.damageType)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    end

    return info.damage
end

return abilityObject
