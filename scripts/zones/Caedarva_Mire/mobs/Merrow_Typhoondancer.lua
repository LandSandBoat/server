-----------------------------------
-- Area: Caedarva Mire (79)
--  Mob: Merrow Typhoondancer
-- Note: Minion of Experimental Lamia
-----------------------------------
mixins =
    {
        require('scripts/mixins/job_special'),
        require('scripts/mixins/weapon_break')
    }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
