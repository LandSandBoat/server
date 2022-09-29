-----------------------------------
-- Area: Throne Room
-- Name: Bastok Mission 9-2
-- !pos -111 -6 0 165
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------

local content = MissionBattlefield:new({
    zoneId = xi.zone.THRONE_ROOM,
    battlefieldId = xi.battlefield.id.WHERE_TWO_PATHS_CONVERGE,
    menuBit = 1,
    entryNpc = "Throne_Room",
    exitNpc = "Throne_Room_Exit",
    missionArea = xi.mission.log_id.BASTOK,
    mission = xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE,
    requiredMissionStatus = 1,
    skipMissionStatus = 4,
})

function content:onBattlefieldInitialise(battlefield)
    Battlefield.onBattlefieldInitialise(self, battlefield)
    battlefield:setLocalVar("phaseChange", 1)
end

return content:register()
