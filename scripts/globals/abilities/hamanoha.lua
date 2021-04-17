-----------------------------------
-- Ability: Hamanoha
-- Description: Lowers accuracy, evasion, magic accuracy, magic evasion and TP gain for demons.
-- Obtained: SAM Level 87
-- Recast Time: 00:05:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local jpValue = target:getJobPointLevel(xi.jp.HAMANOHA_DURATION)

    target:addStatusEffect(xi.effect.HAMANOHA, 12, 0, 180 + jpValue)
end

return ability_object
