-----------------------------------
-- Ability: Fly High
-- Description Decreases the recast time of jumps.
-- Obtained: DRG Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.FLY_HIGH,14,0,30)
end