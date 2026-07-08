-----------------------------------
-- Hysteric Assault
-- Family: Avatar (Siren)
-- Description: Delivers a threefold attack. Additional Effect: HP Drain
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

-- http://wiki.ffo.jp/html/37933.html
abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 3
    params.fTP               = { 5.0, 5.0, 5.0 } -- TODO: Capture fTPs
    params.fTPSubsequentHits = { 5.0, 5.0, 5.0 }
    -- TODO: Capture wSCs
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.PIERCING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_3
    params.canCrit           = true
    params.criticalChance    = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

        pet:addHP(info.damage) -- This is like Sanguine Blade: https://www.bg-wiki.com/ffxi/Hysteric_Assault
    end

    return info.damage
end

return abilityObject
