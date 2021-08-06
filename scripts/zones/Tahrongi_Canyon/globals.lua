-- Zone: Tahrongi Canyon (117)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function testingTimeCheck(player)
    if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.A_TESTING_TIME then
        local testVar = mission:getVar(player, "KillCount")
        mission:setVar(player, "KillCount", testVar + 1)
    end
end
