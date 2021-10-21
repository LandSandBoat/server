-----------------------------------
-- Ability: Sengikori
-- Description: Grants a bonus to skillchains and magic bursts initiated by your next weapon skill.
-- Obtained: SAM Level 77
-- Recast Time: 00:03:00
-- Duration: 0:01:00 or until next Weapon Skill.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.SENGIKORI, 12, 0, 60)
end

return ability_object
