-----------------------------------
-- Ability: Unbridled Learning
-- Description Allows access to additional blue magic spells.
-- Obtained: BLU Level 95
-- Recast Time: 00:05:00
-- Duration: 00:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    target:addStatusEffect(tpz.effect.UNBRIDLED_LEARNING,16,1,60)
end