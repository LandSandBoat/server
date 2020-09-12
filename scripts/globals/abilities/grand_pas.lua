-----------------------------------
-- Ability: Grand Pas
-- Description Allows flourishes to be performed without finishing moves.
-- Obtained: DNC Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    target:addStatusEffect(tpz.effect.GRAND_PAS,19,1,30)
end