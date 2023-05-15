-----------------------------------
-- Area: South Gustaberg
--   NM: Leaping Lizzy
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

if
    xi and
    xi.zones and
    xi.zones.South_Gustaberg and
    xi.zones.South_Gustaberg.mobs and
    xi.zones.South_Gustaberg.mobs.Leaping_Lizzy
then
    return xi.zones.South_Gustaberg.mobs.Leaping_Lizzy
else
    entity.onMobDeath = function(mob, player, optParams)
        xi.hunts.checkHunt(mob, player, 200)
    end

    return entity
end
