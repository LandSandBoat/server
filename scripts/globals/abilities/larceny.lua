-----------------------------------
-- Ability: Larceny
-- Description	Steals one beneficial effect from the target enemy.
-- Obtained: THF Level 96
-- Recast Time: 01:00:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.LARCENY,6,0,5)
end