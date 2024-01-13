-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Magicked Bones
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}

local function despawn_check(mob)
    local totd = VanadielTOTD()
    if totd ~= xi.time.NIGHT and totd ~= xi.time.MIDNIGHT then
        DespawnMob(mob:getID())
        return true
    end
    return false
end

entity.onMobInitialize = function(mob)
    if mob:getID() == ID.mob.MAGICKED_BONES_PH_DAGGER + 2 then
        mob:setModelId(1096) -- Dagger Skeleton Model
    else
        mob:setModelId(573) -- Club Skeleton Model
    end
end

entity.onMobSpawn = function(mob)
    if despawn_check(mob) then
        GetMobByID(mob:getID() - 2):spawn() -- Respawn the PH immediately if Bones were wrongly spawned outside of their window
    end
end

entity.onMobRoam = function(mob)
    despawn_check(mob)
end

return entity
