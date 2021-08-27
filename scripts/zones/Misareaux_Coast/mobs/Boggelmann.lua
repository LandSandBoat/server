-----------------------------------
-- Area: Misareaux Coast
--  Mob: Boggelmann
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.CALM_BEFORE_THE_STORM and player:getCharVar("COP_Boggelmann_KILL") == 0) then
        player:setCharVar("COP_Boggelmann_KILL", 1)
    end
end

return entity
