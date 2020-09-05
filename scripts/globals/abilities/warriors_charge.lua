-----------------------------------
-- Ability: Warrior's Charge
-- Will double your next attack.
-- Obtained: Warrior Level 75 (Merit)
-- Recast Time: 5:00
-- Duration: 1:00 or next attack
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local merits = player:getMerit(tpz.merit.WARRIORS_CHARGE)
    player:addStatusEffect(tpz.effect.WARRIOR_S_CHARGE, merits-5, 0, 60)
end
