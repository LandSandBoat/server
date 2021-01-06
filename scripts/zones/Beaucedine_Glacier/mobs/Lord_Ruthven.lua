-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Lord Ruthven
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.RUTHVEN_ENTOMBER)
end

return entity
