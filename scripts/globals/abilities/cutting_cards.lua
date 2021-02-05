-----------------------------------
-- Ability: Cutting Cards
-- Description: Reduces the recast times of other party members' special abilities. The degree to which they are reduced is determined by the number rolled.
-- Obtained: COR Level 96
-- Recast Time: 01:00:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onUseAbility = function(caster, target, ability, action)
    if caster:getID() == target:getID() then
        local roll = math.random(1, 6)
        caster:setLocalVar("corsairRollTotal", roll)
        action:speceffect(caster:getID(), roll)
    end

    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.doCuttingCards(caster, target, ability, action, total)
end

return ability_object
