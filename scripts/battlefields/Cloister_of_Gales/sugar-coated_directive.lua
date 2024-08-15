-----------------------------------
-- Area: Cloister of Gales
-- BCNM: Sugar Coated Directive (ASA-4)
-----------------------------------
local cloisterOfGalesID = zones[xi.zone.CLOISTER_OF_GALES]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.CLOISTER_OF_GALES,
    battlefieldId = xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_GALES,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 99,
    timeLimit     = utils.minutes(30),
    index         = 4,
    entryNpc      = 'WP_Entrance',
    exitNpc       = 'Wind_Protocrystal',

    requiredKeyItems = { xi.ki.DOMINAS_EMERALD_SEAL, keep = true },
    missionArea      = xi.mission.log_id.ASA,
    mission          = xi.mission.id.asa.SUGAR_COATED_DIRECTIVE,
    requiredVar      = 'Mission[11][3]Garuda',
    requiredValue    = 1,

    grantXP = 400,
})

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfGalesID.mob.GARUDA_PRIME_ASA     },
            { cloisterOfGalesID.mob.GARUDA_PRIME_ASA + 1 },
            { cloisterOfGalesID.mob.GARUDA_PRIME_ASA + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
