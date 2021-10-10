-----------------------------------
-- Geocrush
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
    local tp = skill:getTP() / 10
    local master = pet:getMaster()
    local merits = 0
    if (master ~= nil and master:isPC()) then
        merits = master:getMerit(xi.merit.WIND_BLADE)
    end

    tp = tp + (merits - 40)
    if (tp > 300) then
        tp = 300
    end

    --note: this formula is only accurate for level 75 - 76+ may have a different intercept and/or slope
    local damage = math.floor(512 + 1.72*(tp+1))
    damage = damage + (dINT * 1.5)
    damage = MobMagicalMove(pet, target, skill, damage, xi.magic.ele.WIND, 1, TP_NO_EFFECT, 0)
    damage = mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.WIND)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.WIND)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return ability_object
