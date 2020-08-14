-----------------------------------
-- Ability: Futae
-- Grants a bonus to your next elemental ninjutsu by expending two ninja tools.
-- Obtained: Ninja Level 77
-- Recast Time: 3:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    target:addStatusEffect(tpz.effect.FUTAE, 0, 0, 60)
end
