-----------------------------------
-- Ability: Cutting Cards
-- Description: Reduces the recast times of other party members' special abilities. The degree to which they are reduced is determined by the number rolled.
-- Obtained: COR Level 96
-- Recast Time: 01:00:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(caster, target, ability, action)
    corsair.useCuttingCards(caster, target, ability, action)
end

return ability_object
