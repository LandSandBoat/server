-----------------------------------
-- Ability: BRAZEN_RUSH
-- Increases double attack rate
-- Obtained: WAR Level 96
-- Recast Time: 1:00:00
-- Duration: 0:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.BRAZEN_STRENGTH,1,368,30)
end
