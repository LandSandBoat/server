-----------------------------------
-- Area: Cloister of Tremors
-- BCNM: Sugar Coated Directive (ASA-4)
-----------------------------------
local cloisterOfTremorsID = zones[xi.zone.CLOISTER_OF_TREMORS]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.CLOISTER_OF_TREMORS,
    battlefieldId = xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_TREMORS,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 99,
    timeLimit     = utils.minutes(30),
    index         = 4,
    entryNpc         = 'EP_Entrance',
    exitNpc          = 'Earth_Protocrystal',

    requiredKeyItems = { xi.ki.DOMINAS_AMBER_SEAL, keep = true },
    missionArea      = xi.mission.log_id.ASA,
    mission          = xi.mission.id.asa.SUGAR_COATED_DIRECTIVE,
    requiredVar      = 'Mission[11][3]Titan',
    requiredValue    = 1,

    grantXP = 400,
})

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfTremorsID.mob.TITAN_PRIME_ASA     },
            { cloisterOfTremorsID.mob.TITAN_PRIME_ASA + 1 },
            { cloisterOfTremorsID.mob.TITAN_PRIME_ASA + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
