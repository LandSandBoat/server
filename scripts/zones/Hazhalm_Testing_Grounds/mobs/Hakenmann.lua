-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Hakenmann (Einherjar)
-- Notes: Uses the same TP move 3 times in a row.
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
        action == xi.action.MOBABILITY_START or
        action == xi.action.MOBABILITY_USING or
        action == xi.action.MOBABILITY_FINISH
    then
        return false
    end

    return true
end

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('tpMoveCount', 3)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getLocalVar('tpMoveCount') == 0 then
        mob:setLocalVar('tpMoveCount', 3)
    end

    return mob:getLocalVar('tpMove')
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: If one move is stunned, the sequence is stopped
    local tpMoveCount = mob:getLocalVar('tpMoveCount')
    if tpMoveCount - 1 > 0 then
        mob:setLocalVar('tpMoveCount', tpMoveCount - 1)
        mob:setLocalVar('tpMove', skill:getID())
    else
        mob:setLocalVar('tpMoveCount', 0)
        mob:setLocalVar('tpMove', 0)
    end
end

entity.onMobFight = function(mob)
    if notBusy(mob) and mob:getLocalVar('tpMove') ~= 0 then
        mob:setTP(3000)
    end
end

return entity
