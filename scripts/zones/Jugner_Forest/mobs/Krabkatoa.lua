-----------------------------------
-- Area: Jugner Forest
--  VNM: Krabkatoa
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.KRABKATOA_STEAMER)
end

return entity
