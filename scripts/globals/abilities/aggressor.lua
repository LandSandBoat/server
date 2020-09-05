-----------------------------------
-- Ability: Aggressor
-- Enhances accuracy but impairs evasion.
-- Obtained: Warrior Level 45
-- Recast Time: 5:00
-- Duration: 3:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local merits = player:getMerit(tpz.merit.AGGRESSIVE_AIM)
    player:addStatusEffect(tpz.effect.AGGRESSOR, merits, 0, 180 + player:getMod(tpz.mod.AGGRESSOR_DURATION))
end
