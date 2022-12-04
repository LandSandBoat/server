-----------------------------------
-- Concentric Pulse
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/utils")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local master             = pet:getMaster()
    local masterEquippedHead = master:getEquipID(xi.slot.HEAD)
    local dmgBoost           = master:getJobPointLevel(xi.jp.CONCENTRIC_PULSE_EFFECT)
    local dmg                = pet:getHP()

    if
        masterEquippedHead == xi.items.BAGUA_GALERO_P2 or
        masterEquippedHead == xi.items.BAGUA_GALERO_P3
    then
        dmg = pet:getMaxHP()
    end

    if dmgBoost > 0 then
        dmg = dmg + (dmg * 0.01 * dmgBoost)
    end

    dmg = utils.stoneskin(target, dmg)

    target:takeDamage(dmg, pet, xi.attackType.MAGICAL, xi.damageType.NONE)

    pet:timer(200, function(mobArg)
        mobArg:setHP(0)
    end)

    return dmg
end

return abilityObject
