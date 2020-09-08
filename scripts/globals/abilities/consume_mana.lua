-----------------------------------
-- Ability: Consume Mana
-- Converts all MP into damage for the next attack.
-- Obtained: Dark Knight Level 55
-- Recast Time: 1:00 (or next attack)
-- Duration: 1:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
   player:addStatusEffect(tpz.effect.CONSUME_MANA, 1, 0, 60)
end
