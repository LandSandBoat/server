-----------------------------------
-- Ability: Triple Shot
-- Description Occasionally uses three units of ammunition to deal extra damage.
-- Obtained: COR Level 87
-- Recast Time: 00:05:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.TRIPLE_SHOT,17,0,60)
end