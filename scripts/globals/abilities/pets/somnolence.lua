-----------------------------------
-- Somnolence
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
    local dmg = 10 + pet:getMainLvl() * 2
    local resist = applyPlayerResistance(pet, -1, target, 0, xi.skill.ELEMENTAL_MAGIC, xi.magic.ele.DARK)
    local duration = 120

    dmg = dmg*resist
    dmg = mobAddBonuses(pet, target, dmg, xi.magic.ele.DARK)

    -- TODO: spell is nil here
    --dmg = finalMagicAdjustments(pet, target, spell, dmg)

    if (resist < 0.15) then  --the gravity effect from this ability is more likely to land than Tail Whip
        resist = 0
    end

    duration = duration * resist

    if (duration > 0 and target:hasStatusEffect(xi.effect.WEIGHT) == false) then
        target:addStatusEffect(xi.effect.WEIGHT, 50, 0, duration)
    end

    return dmg
end

return ability_object
