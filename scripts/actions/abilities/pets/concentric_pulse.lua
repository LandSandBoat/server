-----------------------------------
-- Concentric Pulse
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.geomancer.geoOnConcentricPulseAbilityCheck(player, target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, master, action)
    local masterEquippedHead = master:getEquipID(xi.slot.HEAD)
    local dmgBoost           = master:getJobPointLevel(xi.jp.CONCENTRIC_PULSE_EFFECT)
    local dmg                = pet:getHP()

    if
        masterEquippedHead == xi.item.BAGUA_GALERO_P2 or
        masterEquippedHead == xi.item.BAGUA_GALERO_P3
    then
        dmg = pet:getMaxHP()
    end

    if dmgBoost > 0 then
        dmg = dmg + (dmg * 0.01 * dmgBoost)
    end

    -- TODO: Affected by Phalanx, MDT, Magic Damage % modifiers, OneForAll?
    dmg = utils.handleStoneskin(target, dmg)

    target:takeDamage(dmg, pet, xi.attackType.MAGICAL, xi.damageType.NONE)

    pet:timer(200, function(mobArg)
        mobArg:setHP(0)
    end)

    return dmg
end

return abilityObject
