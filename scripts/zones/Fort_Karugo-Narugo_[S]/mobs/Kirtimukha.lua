-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Kirtimukha
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 523)
end

return entity
