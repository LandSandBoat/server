-----------------------------------
-- Area: Beadeaux (254)
--   NM: Da'Dha Hundredmask
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 241)
end

return entity
