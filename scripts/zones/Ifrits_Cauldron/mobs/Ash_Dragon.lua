-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Ash Dragon
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.DRAGON_ASHER)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(259200, 432000)) -- 3 to 5 days
end

return entity
