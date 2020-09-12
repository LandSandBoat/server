-----------------------------------
-- Ability: Inner Strength
-- Description	Increases your maximum HP.
-- Obtained: MNK Level 96
-- Recast Time: 01:00:00
-- Duration: 0:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.INNER_STRENGTH,2,0,30)
end