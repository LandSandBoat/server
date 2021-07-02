-----------------------------------
-- Nether Blast
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")

-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    local level = pet:getMainLvl()
    local damage = (5 * level +  10)
    damage = MobMagicalMove(pet, target, skill, damage, xi.magic.ele.DARK, 1, TP_NO_EFFECT, 0)
    damage = mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.DARK)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.DARK)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return ability_object
