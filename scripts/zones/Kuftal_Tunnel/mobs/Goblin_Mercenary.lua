-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Goblin Mercenary
-- Note: Place Holder for Bloodthirster Madkix
-----------------------------------
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 740, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BLOODTHIRSTER_MADKIX_PH, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
