-----------------------------------
-- Area: FeiYin
--  Mob: Colossus
-- Note: PH for Goliath
-----------------------------------
require("scripts/globals/regimes")
local ID = require("scripts/zones/FeiYin/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 715, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    if ID.mob.GOLIATH_PH[mob:getID()] then
        xi.mob.phOnDespawn(mob, ID.mob.GOLIATH_PH, 10, 1) -- No minimum respawn
    end

    if mob:getID() == 17613052 then
        local path =
        {
            [1] = { -168.000, 0, 170.000, 125 },
            [2] = { -168.000, 0, 150.000, 125 },
            [3] = { -168.000, 0, 130.000, 125 },
            [4] = { -192.000, 0, 130.000, 255 },
            [5] = { -192.000, 0, 150.000, 255 },
            [6] = { -192.000, 0, 170.000, 255 },
        }
        local randompos = math.random(1, 6)
        local xPos = path[randompos][1]
        local yPos = path[randompos][2]
        local zPos = path[randompos][3]
        local rot  = path[randompos][4]

        mob:setSpawn(xPos, yPos, zPos, rot)
    end
end

return entity
