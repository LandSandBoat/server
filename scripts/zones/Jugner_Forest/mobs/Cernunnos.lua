-----------------------------------
-- Area: Jugner Forest
--   NM: Cernunnos
-----------------------------------
mixins = { require('scripts/mixins/job_special') } -- TODO: Is this right?
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:setLocalVar('cernunnosDefeated', 1)
end

return entity
