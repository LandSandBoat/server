-----------------------------------
-- Geocrush
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

    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp = skill:getTP() / 10
    local master = pet:getMaster()
    local merits = 0
    if (master ~= nil and master:isPC()) then
        merits = master:getMerit(xi.merit.GEOCRUSH)
    end

    tp = tp + (merits - 40)
    if (tp > 300) then
        tp = 300
    end

    --note: this formula is only accurate for level 75 - 76+ may have a different intercept and/or slope
    local damage = math.floor(512 + 1.72*(tp+1))
    damage = damage + (dINT * 1.5)
    damage = MobMagicalMove(pet, target, skill, damage, xi.magic.ele.EARTH, 1, TP_NO_EFFECT, 0)
    damage = mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.EARTH)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.EARTH)
    target:updateEnmityFromDamage(pet, damage)

    if (target:hasStatusEffect(xi.effect.STUN) == false) then
        target:addStatusEffect(xi.effect.STUN, 3, 3, 3)
    end

    return damage
end

return ability_object
