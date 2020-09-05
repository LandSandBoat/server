-----------------------------------
-- Ability: Mighty Strikes
-- Turns all melee attacks into critical hits.
-- Obtained: Warrior Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:45
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.MIGHTY_STRIKES, 1, 0, 45)
end
