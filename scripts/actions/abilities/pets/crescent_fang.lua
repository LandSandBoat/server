-----------------------------------
-- Crescent Fang M=6
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 1.50, 3.75, 6.00 } -- TODO: Capture 2000 fTP. Using 3.75 for now (Linear scaling).
    params.fTPSubsequentHits = { 1.50, 3.75, 6.00 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.PIERCING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.PARALYSIS, power = 22, duration = 60, origin = pet }, -- TODO: Capture power
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return abilityObject
