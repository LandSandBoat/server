-----------------------------------
-- Diamond Dust
-- Family: Shiva (Player Pet)
-- Note: Shiva's Astral Flow
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage      = pet:getMainLvl() + 2
    params.fTP             = { 9.0, 9.0, 9.0 }
    params.int_wSC         = 0.30
    params.element         = xi.element.ICE
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.ICE
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1.5
    params.canMagicBurst   = true
    params.primaryMessage  = xi.msg.basic.USES_JA_TAKE_DAMAGE
    -- TODO: Should not consume TP

    local info = xi.mobskills.mobMagicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    summoner:setMP(0)

    return info.damage
end

return abilityObject
