-----------------------------------
-- Ability: Assassin's Charge
-- Will triple your next attack.
-- Obtained: Thief Level 75
-- Recast Time: 5:00
-- Duration: 1:00 minute
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local merits = player:getMerit(tpz.merit.ASSASSINS_CHARGE)
    local crit = 0
    if player:getMod(tpz.mod.AUGMENTS_ASSASSINS_CHARGE) > 0 then
        crit = merits / 5
    end

    player:addStatusEffect(tpz.effect.ASSASSINS_CHARGE, merits - 5, 0, 60, 0, crit)
end

return ability_object
