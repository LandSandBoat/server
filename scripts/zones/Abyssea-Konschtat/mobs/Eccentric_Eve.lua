-----------------------------------
-- Area: Abyssea - Konschtat (15)
--   NM: Eccentric Eve
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ECCENTRICITY_EXPUNGER)
end

return entity
