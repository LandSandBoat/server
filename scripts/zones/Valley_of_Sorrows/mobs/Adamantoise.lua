-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Adamantoise
-----------------------------------
local ID = zones[xi.zone.VALLEY_OF_SORROWS]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, mixins.rage, { rageTimer = utils.minutes(30) })
end

entity.onMobSpawn = function(mob)
    -- Despawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TORTOISE_TORTURER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
