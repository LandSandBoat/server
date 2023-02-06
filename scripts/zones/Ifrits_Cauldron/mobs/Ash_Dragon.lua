-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Ash Dragon
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobFight = function(mob, target)
    local drawInTableNorth =
    {
        condition1 = target:getXPos() < -290 and target:getZPos() > 130,
        position   = { -291.05, 40.0, 130.5, target:getRotPos() },
    }
    local drawInTableSouth =
    {
        condition1 = target:getXPos() > -230 and target:getZPos() < 69.5,
        position   = { -229.0, 40.0, 70, target:getRotPos() },
    }

    utils.arenaDrawIn(mob, target, drawInTableNorth)
    utils.arenaDrawIn(mob, target, drawInTableSouth)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.DRAGON_ASHER)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(259200, 432000)) -- 3 to 5 days
end

return entity
