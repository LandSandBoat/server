-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Warchief Vatgit
-- Involved in Mission 2-3
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)

    if (player:getCurrentMission(player:getNation()) == 6) then
        if (player:getCharVar("MissionStatus") == 4) then
            player:setCharVar("MissionStatus", 5)
        end
    end

    player:addTitle(tpz.title.WARCHIEF_WRECKER)

end
