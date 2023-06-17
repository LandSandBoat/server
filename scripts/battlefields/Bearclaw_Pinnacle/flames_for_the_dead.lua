-----------------------------------
-- Flames for the Dead
-- Bearclaw Pinnacle mission battlefield
-- !pos -720 9 -441 6
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/titles")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId = xi.battlefield.id.FLAMES_FOR_THE_DEAD,
    maxPlayers    = 6,
    levelCap      = 99,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = "Wind_Pillar_1",
    exitNpc       = "Wind_Pillar_Exit",

    missionArea           = xi.mission.log_id.COP,
    mission               = xi.mission.id.cop.THREE_PATHS,
    missionStatusArea     = xi.mission.log_id.COP,
    missionStatus         = xi.mission.status.COP.ULMIA,
    requiredMissionStatus = 8,
    title                 = xi.title.TRUE_COMPANION_OF_LOUVERANCE,
    grantXP               = 1000,
})

content:addEssentialMobs({ "Snoll_Tzar" })

return content:register()
