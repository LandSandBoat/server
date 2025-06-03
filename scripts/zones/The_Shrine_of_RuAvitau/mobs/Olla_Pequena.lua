-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Olla Pequena
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        SpawnMob(mob:getID() + 1):updateClaim(player)
    end
end

entity.onMobDespawn = function(mob)
    if not GetMobByID(mob:getID() + 1):isSpawned() then -- if this Pequena despawns and Media is not alive, it would be because it despawned outside of being killed.
        GetNPCByID(ID.npc.OLLAS_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
