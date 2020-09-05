-----------------------------------
-- Ability: Mikage
-- Grants a bonus to number of main weapon attacks that varies with the number of remaining Utsusemi Shadow Images.
-- Obtained: Ninja Level 96
-- Recast Time: 1:00:00
-- Duration: 45 seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:addStatusEffect(tpz.effect.MIKAGE, 0, 0, 45)
end
