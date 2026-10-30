-----------------------------------
-- Area: Leujaoam Sanctum (Orichalcum Survey)
--  Mob: Mineral Eater
-----------------------------------
---@type TMobEntity
local entity = {}

local function linkedPointID(mob)
    local pointID = mob:getLocalVar('pointId')
    if pointID ~= 0 then
        return pointID
    end

    return nil
end

local function setPointWormState(mob, isActive)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local pointID = linkedPointID(mob)
    if not pointID then
        return
    end

    local point = GetNPCByID(pointID, instance)
    if point then
        point:setLocalVar('wormActive', isActive and 1 or 0)
        if not isActive then
            point:setLocalVar('wormMobId', 0)
        end
    end
end

entity.onMobSpawn = function(mob)
    mob:setMaxHP(1700)
    mob:setHP(1700)
    xi.assault.adjustMobLevel(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setAnimationSub(0)
    setPointWormState(mob, true)
end

entity.onMobDespawn = function(mob)
    setPointWormState(mob, false)
end

return entity
