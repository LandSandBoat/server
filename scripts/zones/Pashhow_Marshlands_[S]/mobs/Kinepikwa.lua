-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Kinepikwa
-----------------------------------
mixins = {
    require('scripts/mixins/job_special'),
    require('scripts/mixins/families/peiste'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 507)
end

return entity
