-----------------------------------
-- Searing Light
-----------------------------------
require("/scripts/globals/settings")
require("/scripts/globals/status")
require("/scripts/globals/monstertpmoves")
require("/scripts/globals/magic")

-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local level = player:getMainLvl() * 2

    if(player:getMP()<level) then
       return 87, 0
    end

    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill, master)
    local dINT = math.floor(pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))

    local level = pet:getMainLvl()
    local damage = 26 + (level * 6)
    damage = damage + (dINT * 1.5)
    damage = MobMagicalMove(pet, target, skill, damage, tpz.magic.ele.LIGHT, 1, TP_NO_EFFECT, 0)
    damage = mobAddBonuses(pet, nil, target, damage.dmg, tpz.magic.ele.LIGHT)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, 1)

    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    target:updateEnmityFromDamage(pet, damage)
    master:setMP(0)

    return damage
end

return ability_object
