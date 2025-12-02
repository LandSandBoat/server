-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Tanngrisnir (Einherjar)
-- Notes: Mix of Dahak and Dragons TP moves
-- May use back to back TP moves (up to 3)
-- Actual trigger, if any, is unknown.
-- Assumed to be random. Verify with more captures.
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

local function notBusy(mob)
    local action = mob:getCurrentAction()
    if
        action == xi.action.category.MOBABILITY_START or
        action == xi.action.category.MOBABILITY_USING or
        action == xi.action.category.MOBABILITY_FINISH
    then
        return false
    end

    return true
end

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local requeueCount = mob:getLocalVar('requeue')
    if requeueCount ~= 0 then -- continue the current sequence
        mob:setLocalVar('requeue', requeueCount - 1)
    elseif math.random(1, 100) <= 60 then -- 60% chance to start a new sequence
        mob:setLocalVar('requeue', math.random(1, 2))
    end
end

entity.onMobFight = function(mob, target)
    if notBusy(mob) and mob:getLocalVar('requeue') ~= 0 then
        mob:setTP(3000)
    end
end

return entity
