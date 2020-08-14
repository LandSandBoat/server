-----------------------------------
-- Ability: Souleater
-- Consumes your own HP to enhance attacks.
-- Obtained: Dark Knight Level 30
-- Recast Time: 6:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
   player:addStatusEffect(tpz.effect.SOULEATER, 1, 0, 60)
end
