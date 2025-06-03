-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Olla Grande
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.OLLAS_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
