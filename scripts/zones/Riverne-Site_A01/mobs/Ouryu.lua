-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Ouryu
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.OURYU_OVERWHELMER)
end

return entity
