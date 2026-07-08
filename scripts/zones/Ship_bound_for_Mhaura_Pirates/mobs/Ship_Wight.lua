-----------------------------------
-- Area: Ship bound for Mhaura Pirates
--  Mob: Ship Wight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setRespawnTime(60) -- Respawns every 60s while the pirate ship is alongside.
end

entity.onMobDespawn = function(mob)
    local zone = mob:getZone()
    if not zone then
        return
    end

    -- On an HQ ride, the Ship Wight is Silverhook's placeholder (90%) until he appears.
    if zone:getLocalVar('nmCanSpawn') == 0 then
        return
    end

    if math.randomInt(1, 100) > 90 then
        return
    end

    local silverhook = GetMobByID(zones[xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES].mob.SILVERHOOK)
    if not silverhook then
        return
    end

    mob:setRespawnTime(0) -- This Wight stays down; Silverhook takes its slot.
    silverhook:setRespawnTime(1)
    zone:setLocalVar('nmCanSpawn', 0)
end

return entity
