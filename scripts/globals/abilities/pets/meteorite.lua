---------------------------------------------------
-- Meteorite
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    local dint = pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local dmg = 500 + dint*1.5 + skill:getTP()/20
    target:updateEnmityFromDamage(pet, dmg)
    target:takeDamage(dmg, pet, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    return dmg
end

return ability_object
