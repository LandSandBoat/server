-----------------------------------
-- Regal Scratch
-- Family: Avatar (Cait Sith)
-- Description: Delivers a threefold attack.
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    -- https://wiki.ffo.jp/html/26384.html
    -- JP Wiki states that this skill was excluded from carrying first hit fTP to subsequent hits.
    -- (See Patch note history for November 10th, 2016 in above link.)

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 3
    params.fTP               = { 3.00, 3.00, 3.00 } -- TODO: Capture fTPs
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    -- params.dex_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_3
    -- params.accuracyModifier   = { 0, 0, 0 } TODO: Capture accuracy
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end

return abilityObject
