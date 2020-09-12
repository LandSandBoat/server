-----------------------------------
-- Ability: Cutting Cards
-- Description	Reduces the recast times of other party members' special abilities. The degree to which they are reduced is determined by the number rolled.
-- Obtained: COR Level 96
-- Recast Time: 01:00:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onUseAbility(caster, target, ability, action)
    if (caster:getID() == target:getID()) then
        local roll = math.random(1, 6)
        caster:setLocalVar("corsairRollTotal", roll)
        action:speceffect(caster:getID(), roll)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return applyRoll(caster, target, ability, action, total)
end

function applyRoll(caster, target, ability, action, total)
    caster:doCuttingCards(target, total)
    ability:setMsg(435 + math.floor((total-1)/2)*2)
    action:animation(target:getID(), 132 + (total) - 1)
    return total
end