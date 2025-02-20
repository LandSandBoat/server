-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Water Elemental
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    if mob:getID() == ID.mob.APPARATUS_ELEMENTAL then
        mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
