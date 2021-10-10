-----------------------------------
-- Thunder 2
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")

-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp = skill:getTP()

    local damage = math.floor(45 + 0.025*(tp))
    damage = damage + (dINT * 1.5)
    damage = MobMagicalMove(pet, target, skill, damage, xi.magic.ele.LIGHTNING, 1, TP_NO_EFFECT, 0)
    damage = mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.LIGHTNING)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return ability_object
