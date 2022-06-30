-----------------------------------
-- Ability: Souleater
-- Consumes your own HP to enhance attacks.
-- Obtained: Dark Knight Level 30
-- Recast Time: 6:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local jpValue = target:getJobPointLevel(xi.jp.SOULEATER_DURATION)

    player:addStatusEffect(xi.effect.SOULEATER, 1, 0, 60 + jpValue)
end

return ability_object
