-----------------------------------
-- Ability: Astral Conduit
-- Description Reduces Blood Pact recast times.
-- Obtained: SMN Level 96
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
    player:addStatusEffect(tpz.effect.ASTRAL_CONDUIT,15,1,30)
end