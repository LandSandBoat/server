-----------------------------------
-- Ability: Divine Emblem
-- Description Enhances the accuracy of your next divine magic spell and increases enmity.
-- Obtained: PLD Level 78
-- Recast Time: 00:03:00
-- Duration: 00:01:00 or the next spell cast
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.DIVINE_EMBLEM,7,0,60)
end