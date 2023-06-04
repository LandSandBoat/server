-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Warchief Vatgit
-- Involved in Mission 2-3
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/titles")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getCurrentMission(player:getNation()) == xi.mission.id.nation.RANK2 and
        player:getNation() == xi.nation.WINDURST
    then
        if player:getMissionStatus(player:getNation()) == 4 then
            player:setMissionStatus(player:getNation(), 5)
        end
    end

    player:addTitle(xi.title.WARCHIEF_WRECKER)
end

return entity
