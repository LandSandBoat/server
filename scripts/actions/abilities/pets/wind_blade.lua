-----------------------------------
-- Wind Blade
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    -- Merit TP bonus.
    local merits = 0

    if summoner and summoner:isPC() then
        merits = utils.clamp(summoner:getMerit(xi.merit.WIND_BLADE) - 400, 0, 3000)
    end

    local params = {}

    params.baseDamage      = pet:getMainLvl() + 2
    params.fTP             = { 5.3570, 8.0273, 10.7031 }
    params.fTPBonus        = merits
    params.int_wSC         = 0.30
    params.element         = xi.element.WIND
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.WIND
    params.shadowBehavior  = xi.mobskills.shadowBehavior.NUMSHADOWS_1 -- TODO: Capture shadowBehavior
    params.dStatMultiplier = 1.5
    params.canMagicBurst   = true
    params.primaryMessage  = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobMagicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end

return abilityObject
