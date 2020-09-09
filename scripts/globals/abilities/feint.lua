-----------------------------------
-- Ability: Feint
-- Reduces targets evasion by -150 (Assassin's Culottes +2 Aug: -10 more eva per merit)
-- Obtained: Thief Level 75
-- Recast Time: 2:00 minutes
-- Duration: 1:00 minutes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local augment = player:getMod(tpz.mod.AUGMENTS_FEINT) * player:getMerit(tpz.merit.FEINT) / 25 -- Divide by the merit value (feint is 25) to get the number of merit points
    player:addStatusEffect(tpz.effect.FEINT, 150 + augment, 0, 60) -- -150 Evasion base
end
