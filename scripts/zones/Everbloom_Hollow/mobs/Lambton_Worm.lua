-----------------------------------
-- Area: Everbloom Hollow
--  Mob: Lambton Worm
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.LAMBTON_WORM_DESEGMENTER)
end

return entity
