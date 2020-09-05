-----------------------------------
-- Ability: Release
-- Sends the avatar away.
-- Obtained: Summoner Level 1
-- Recast Time: 10 seconds (shared by all avatars)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:despawnPet()
    target:delStatusEffect(tpz.effect.AVATAR)
end
