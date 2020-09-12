-----------------------------------
-- Ability: Tactical Switch
-- Description Swaps TP of master and automaton.
-- Obtained: PUP Level 79
-- Recast Time: 00:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    target:addStatusEffect(tpz.effect.TACTICAL_SWITCH,18,1,1)
end