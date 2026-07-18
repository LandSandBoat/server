-----------------------------------
-- Area: Phanauet Channel (1)
--   NM: Vodyanoi
-- !pos -2.0 -3.0 9.6 1
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- Burn the 21-24 hour window the instant he appears, so a pop that nobody stays aboard
    -- to kill still consumes the cooldown. The barge ride rolls against this in the zone
    -- script. Set here rather than on despawn, as an empty channel never ticks the mob.
    mob:setLocalVar('respawn', GetSystemTime() + math.randomInt(75600, 86400)) -- 21 to 24 hours.

    -- The zone script's setRespawnTime leaves him allowed to respawn on a short timer, which
    -- would pop him again every few minutes. Only a successful roll may bring him back.
    DisallowRespawn(mob:getID(), true)
end

return entity
