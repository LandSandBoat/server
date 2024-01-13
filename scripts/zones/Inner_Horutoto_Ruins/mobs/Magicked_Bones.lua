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
    end
end

entity.onMobInitialize = function(mob)
    if mob:getID() == ID.mob.MAGICKED_BONES_PH_DAGGER + 2 then
        mob:setModelId(1096) -- Dagger Skeleton Model
    else
        mob:setModelId(573) -- Club Skeleton Model
    end
end

entity.onMobRoam = function(mob)
    despawn_check(mob)
end

return entity
