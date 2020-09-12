-----------------------------------
-- Ability: Unbridled Wisdom
-- Description Allows certain blue magic spells to be cast.
-- Obtained: BLU Level 96
-- Recast Time: 01:00:00
-- Duration: 00:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    target:addStatusEffect(tpz.effect.UNBRIDLED_WISDOM,16,1,30)
end