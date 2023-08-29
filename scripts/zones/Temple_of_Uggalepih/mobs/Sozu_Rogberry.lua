-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Sozu Rogberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 390)
end

return entity
