-----------------------------------
-- Ability: Majesty
-- Description Increases Cure potency and reduces Cure recast time. Additionally, causes Cure and Protect spells to affect party members in area of effect.
-- Obtained: PLD Level 70
-- Recast Time: 00:01:00
-- Duration: 00:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.MAJESTY,7,0,180)
end