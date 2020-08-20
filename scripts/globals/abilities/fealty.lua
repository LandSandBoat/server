-----------------------------------
-- Ability: Fealty
-- Grants a powerful resistance to enfeebling magic.
-- Obtained: Paladin Level 75
-- Recast Time: 0:10:00
-- Duration: 0:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local power = player:getMerit(tpz.merit.FEALTY)

    player:addStatusEffect(tpz.effect.FEALTY, power, 0, 60 + (power * 5))
end
