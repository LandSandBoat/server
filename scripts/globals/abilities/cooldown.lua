-----------------------------------
-- Ability: Cooldown
-- Description Reduces the strain on your automaton.
-- Obtained: PUP Level 95
-- Recast Time: 00:05:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.COOLDOWN,18,1,1)
end