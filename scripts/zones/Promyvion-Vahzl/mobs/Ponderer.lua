-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Ponderer
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 5 then
        player:setCharVar("PromathiaStatus", 6)
    end
end

return entity
