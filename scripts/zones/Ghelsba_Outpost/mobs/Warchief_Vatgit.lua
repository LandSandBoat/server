-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Warchief Vatgit
-- Involved in Mission 2-3
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)

    if (player:getCurrentMission(player:getNation()) == 6) then
        if (player:getMissionStatus(player:getNation()) == 4) then
            player:setMissionStatus(player:getNation(), 5)
        end
    end

    player:addTitle(xi.title.WARCHIEF_WRECKER)

end

return entity
