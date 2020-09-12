-----------------------------------
-- Ability: Clarion Call
-- Description	Increases the number of songs that can affect party members by one.
-- Obtained: BRD Level 96
-- Recast Time: 01:00:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.CLARION_CALL,10,0,180)
end