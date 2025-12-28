-----------------------------------
-- Area: Quicksand Caves
--   NM: Centurio IV-VII
-- Bastok mission 8-1 "The Chains that Bind Us"
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

return entity
