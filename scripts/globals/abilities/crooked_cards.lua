-----------------------------------
-- Ability: Crooked Cards
-- Description Increases the effects of the next phantom roll.
-- Obtained: COR Level 95
-- Recast Time: 0:10:00
-- Duration: 0:01:00(or the next roll used)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    target:addStatusEffect(tpz.effect.CROOKED_CARDS,17,0,60)
end