-----------------------------------
-- Ability: Manawell
-- Description Eliminates the cost of the next magic spell the target casts.
-- Obtained: BLM Level 95
-- Recast Time: 00:10:00 or the next spell cast
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    target:addStatusEffect(tpz.effect.MANAWELL,4,0,60)
end