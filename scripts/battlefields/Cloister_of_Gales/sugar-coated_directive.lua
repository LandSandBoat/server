-----------------------------------
-- Area: Cloister of Gales
-- BCNM: Sugar Coated Directive (ASA-4)
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.CLOISTER_OF_GALES,
    battlefieldId = xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_GALES,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = xi.settings.main.MAX_LEVEL,
    timeLimit     = utils.minutes(30),
    index         = 4,
    entryNpc      = 'WP_Entrance',
    exitNpc       = 'Wind_Protocrystal',

    requiredKeyItems = { xi.keyItem.DOMINAS_EMERALD_SEAL, keep = true },
    missionArea      = xi.mission.log_id.ASA,
    mission          = xi.mission.id.asa.SUGAR_COATED_DIRECTIVE,

    grantXP = 400,
})

-- The protocrystal must have refused the seal once this visit. The fight stays open after the mission.
function content:checkRequirements(player, npc, isRegistrant, trade)
    return Battlefield.checkRequirements(self, player, npc, isRegistrant, trade) and
        xi.asa.helpers.sugarCoatedEntry(player)
end

function content:onBattlefieldWin(player, battlefield)
    BattlefieldMission.onBattlefieldWin(self, player, battlefield)
    player:setCharVar(xi.asa.helpers.sugarCoated[xi.zone.CLOISTER_OF_GALES].winVar, 1)
end

content.groups =
{
    {
        mobs = { 'Garuda_Prime_ASA' },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
