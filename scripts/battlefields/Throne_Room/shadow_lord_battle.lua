-----------------------------------
-- Area: Throne Room
-- Name: Mission 5-2
-- !pos -111 -6 0.1 165
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

local content = BattlefieldMission:new({
    zoneId = xi.zone.THRONE_ROOM,
    battlefieldId = xi.battlefield.id.SHADOW_LORD_BATTLE,
    menuBit = 0,
    entryNpc = "Throne_Room",
    exitNpc = "Throne_Room_Exit",
    mission = xi.mission.id.nation.SHADOW_LORD,
    requiredMissionStatus = 3,
})

function content:onBattlefieldInitialise(battlefield)
    Battlefield.onBattlefieldInitialise(self, battlefield)
    battlefield:setLocalVar("phaseChange", 1)
end

return content:register()
