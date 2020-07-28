---------------------------------------------------
-- Meteorite
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local dint = pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local dmg = 500 + dint*1.5 + skill:getTP()/20
    target:updateEnmityFromDamage(pet, dmg)
    target:takeDamage(dmg, pet, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    return dmg
end
