-----------------------------------
-- Ability: Pianissimo
-- Limits area of effect of next song to a single target.
-- Obtained: Bard Level 20
-- Recast Time: 0:00:15
-- Duration: 00:01:00
-----------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.PIANISSIMO, 0, 0, 60)
end
