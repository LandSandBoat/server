-----------------------------------
-- Ability: Burst Affinity
-- Makes it possible for your next "magical" blue magic spell to be used in a Magic Burst.
-- Obtained: Blue Mage Level 25
-- Recast Time: 2 minutes
-- Duration: 30 seconds
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.BURST_AFFINITY, 1, 0, 30)

    return tpz.effect.BURST_AFFINITY
end
