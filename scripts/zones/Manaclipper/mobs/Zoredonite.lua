-- Note: Zoredonite persists on the boat across rides until killed.
-- On death he goes on a 12 hour cooldown before he can spawn again.
-----------------------------------
-- Area: Manaclipper
--   NM: Zoredonite
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/families/uragnite')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, player)
    mob:setLocalVar('[uragnite]inShellRegen', 100)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar('respawn', GetSystemTime() + 43200) -- When killed: 12 hour respawn timer.
    mob:setRespawnTime(0)                               -- Cancel auto-respawn.
end

return entity
