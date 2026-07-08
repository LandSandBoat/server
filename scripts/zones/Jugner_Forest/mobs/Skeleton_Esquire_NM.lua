-----------------------------------
-- Area: Jugner Forest
-- NM: Skeleton Esquire
-- Quest: A Timely Visit
-- TODO: Level is unknown
-----------------------------------
local jugnerID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(jugnerID.npc.TIMELYVISITQM):setLocalVar('Wait', GetSystemTime() + 180) -- Sets a 3 minute wait before the NMs can be repopped
end

return entity
