-----------------------------------
-- Ability: Unleash
-- Description	Increases the accuracy of Charm and reduces the recast times of Sic and Ready.
-- Obtained: BST Level 96
-- Recast Time: 01:00:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.UNLEASH,9,0,60)
end