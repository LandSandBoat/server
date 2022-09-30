-----------------------------------
-- Flames for the Dead
-- Bearclaw Pinnacle mission battlefield
-- !gotoid 16801888
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/missions")
require("scripts/globals/zones")
-----------------------------------

local content = BattlefieldMission:new({
    zoneId = xi.zone.THRONE_ROOM,
    battlefieldId = xi.battlefield.id.FLAMES_FOR_THE_DEAD,
    menuBit = 0,
    entryNpc = "Wind_Pillar_1",
    exitNpc = "Wind_Pillar_Exit",
    missionArea = xi.mission.log_id.COP,
    mission = xi.mission.id.cop.THREE_PATHS,
    missionStatusArea = xi.mission.log_id.COP,
    missionStatus = xi.mission.status.ULMIA,
    requiredMissionStatus = 8,
    title = xi.title.TRUE_COMPANION_OF_LOUVERANCE,
    grantXP = 1000,
})

return content:register()
