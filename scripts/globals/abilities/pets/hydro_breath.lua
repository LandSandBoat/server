-----------------------------------
-- Hydro Breath
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/ability")

-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(pet, target, skill, action)
    local master = pet:getMaster()
    ---------- Deep Breathing ----------
    -- 0 for none
    -- 1 for first merit
    -- 0.25 for each merit after the first
    -- TODO: 0.1 per merit for augmented AF2 (10663 *w/ augment*)
    local deep = 1
    if (pet:hasStatusEffect(xi.effect.MAGIC_ATK_BOOST) == true) then
        deep = deep + 1 + (master:getMerit(xi.merit.DEEP_BREATHING) - 1) * 0.25
        pet:delStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    end

    local gear = master:getMod(xi.mod.WYVERN_BREATH) / 256 -- Master gear that enhances breath

    local dmgmod = MobBreathMove(pet, target, 0.185, pet:getMainLvl() * 15, xi.magic.ele.WATER) -- Works out to (hp/6) + 15, as desired
    dmgmod = (dmgmod * (1 + gear)) * deep
    pet:setTP(0)

    local dmg = AbilityFinalAdjustments(dmgmod, pet, skill, target, xi.attackType.BREATH, xi.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, pet, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end

return ability_object
