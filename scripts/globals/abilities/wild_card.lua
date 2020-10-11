-----------------------------------
-- Ability: Wild Card
-- Has a random effect on all party members within area of effect.
-- Obtained: Corsair Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

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
    caster:doWildCard(target, total)
    ability:setMsg(435 + math.floor((total-1)/2)*2)
    action:animation(target:getID(), 132 + (total) - 1)
    return total
end
