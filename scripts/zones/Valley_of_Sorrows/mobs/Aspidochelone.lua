-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Aspidochelone
-----------------------------------
local ID = zones[xi.zone.VALLEY_OF_SORROWS]
mixins = { require('scripts/mixins/rage') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes

    -- Despawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ASPIDOCHELONE_SINKER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
