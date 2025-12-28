-----------------------------------
-- Area: Jugner Forest
-- NM: Giollemitte B Feroun
-- Quest: A Timely Visit
-- TODO: Level is unknown
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local jugnerID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(jugnerID.npc.TIMELYVISITQM):setLocalVar('Wait', GetSystemTime() + 180) -- Sets a 3 minute wait before the NMs can be repopped
end

return entity
