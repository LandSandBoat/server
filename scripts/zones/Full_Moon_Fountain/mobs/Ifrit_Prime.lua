-----------------------------------
-- Area: Full Moon Fountain
-- Mob: Ifrit Prime
-- Quest: Waking the Beast
-----------------------------------
mixins = { require("scripts/mixins/wtb_prime") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
