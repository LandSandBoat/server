-----------------------------------
-- Area: Caedarva Mire
--  Mob: Jazaraat
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.LOST_KINGDOM) then
        player:setCharVar("AhtUrganStatus", 2)
    end
end

return entity
