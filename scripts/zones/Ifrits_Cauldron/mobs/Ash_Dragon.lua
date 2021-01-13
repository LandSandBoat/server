-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Ash Dragon
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.DRAGON_ASHER)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(259200, 432000)) -- 3 to 5 days
end

return entity
