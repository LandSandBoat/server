-- Note: Zoredonite not despawning when the boat docks is correct to retail behavior. He will respawn on the boat when it takes off again. As long as he is claimed when the boat docks, he will always respawn on the next boat ride.
-- To Do: Venom Shell poison tick rate is 30/HP per tick based on retail captures.
-- To Do: Fix uragnite family mixin. Right now, they do not go into their shells to heal.
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
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('respawn', GetSystemTime() + 43200) -- 12 hour respawn
end

return entity
