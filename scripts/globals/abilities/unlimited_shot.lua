-----------------------------------
-- Ability: Unlimited Shot
-- Allows you to perform your next ranged attack without using ammunition.
-- Obtained: Ranger Level 51
-- Recast Time: 3:00
-- Duration: 1:00 or One Successful Ranged Attack.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.UNLIMITED_SHOT, 1, 0, 60)
end
