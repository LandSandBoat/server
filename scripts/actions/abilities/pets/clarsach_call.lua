-----------------------------------
-- Clarsach Call
-- Family: Siren (Player Pet)
-- Note: Siren's Astral Flow
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

-- https://www.bg-wiki.com/ffxi/Clarsach_Call
abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage      = pet:getMainLvl() + 2
    params.fTP             = { 9, 9, 9 } -- TODO: Need data on fTPs, using standard astral flow ftps for now.
    params.int_wSC         = 0.30
    params.element         = xi.element.WIND
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.WIND
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior
    params.dStatMultiplier = 1.5
    params.canMagicBurst   = true
    params.primaryMessage  = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobMagicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    summoner:setMP(0)

    pet:addStatusEffect(xi.effect.ATTACK_BOOST, { power = 25, duration = 180, origin = pet })
    pet:addStatusEffect(xi.effect.DEFENSE_BOOST, { power = 25, duration = 180, origin = pet })
    pet:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, { power = 25, duration = 180, origin = pet })
    pet:addStatusEffect(xi.effect.MAGIC_DEF_BOOST, { power = 25, duration = 180, origin = pet })
    pet:addStatusEffect(xi.effect.EVASION_BOOST, { power = 50, duration = 180, origin = pet })
    pet:addStatusEffect(xi.effect.MAGIC_EVASION_BOOST, { power = 50, duration = 180, origin = pet })

    return info.damage
end

return abilityObject
