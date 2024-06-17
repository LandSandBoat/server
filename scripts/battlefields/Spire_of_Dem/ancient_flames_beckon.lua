-----------------------------------
-- Ancient Flames Beckon
-- Spire of Dem mission battlefield
-----------------------------------
require('scripts/missions/cop/helpers')
local spireOfDemID = zones[xi.zone.SPIRE_OF_DEM]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.SPIRE_OF_DEM,
    battlefieldId = xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_DEM,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 30,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = '_0j0',
    exitNpcs      = { '_0j1', '_0j2', '_0j3' },

    grantXP = 1500,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    local promathiaMission    = player:getCurrentMission(xi.mission.log_id.COP)
    local currentRequirements = promathiaMission == xi.mission.id.cop.BELOW_THE_ARKS or
        (promathiaMission == xi.mission.id.cop.THE_MOTHERCRYSTALS and not player:hasKeyItem(xi.ki.LIGHT_OF_DEM))
    local nonRegistrantReqs   = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) or currentRequirements

    return (not isRegistrant and nonRegistrantReqs) or currentRequirements
end

function content:checkSkipCutscene(player)
    return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) or
        player:hasKeyItem(xi.ki.LIGHT_OF_DEM)
end

function content:onBattlefieldWin(player, battlefield)
    local _, clearTime, partySize = battlefield:getRecord()

    local arg8        = xi.cop.helpers.numPromyvionCompleted(player, xi.cop.helpers.promyvionCrags.DEM) + 1
    local copMission  = player:getCurrentMission(xi.mission.log_id.COP)
    local promyvionId = (player:getZoneID() - 17) / 2

    if
        (copMission == xi.mission.id.cop.BELOW_THE_ARKS or
        copMission == xi.mission.id.cop.THE_MOTHERCRYSTALS) and
        not player:hasKeyItem(xi.ki.LIGHT_OF_HOLLA + promyvionId)
    then
        player:setLocalVar('newPromy', 1)
    end

    player:setLocalVar('battlefieldWin', battlefield:getID())
    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), player:getZoneID(), self.index, 0, arg8)
end

content.groups =
{
    {
        mobIds =
        {
            { spireOfDemID.mob.PROGENERATOR      },
            { spireOfDemID.mob.PROGENERATOR + 5  },
            { spireOfDemID.mob.PROGENERATOR + 10 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            {
                spireOfDemID.mob.PROGENERATOR + 1,
                spireOfDemID.mob.PROGENERATOR + 2,
                spireOfDemID.mob.PROGENERATOR + 3,
                spireOfDemID.mob.PROGENERATOR + 4
            },

            {
                spireOfDemID.mob.PROGENERATOR + 6,
                spireOfDemID.mob.PROGENERATOR + 7,
                spireOfDemID.mob.PROGENERATOR + 8,
                spireOfDemID.mob.PROGENERATOR + 9,
            },

            {
                spireOfDemID.mob.PROGENERATOR + 11,
                spireOfDemID.mob.PROGENERATOR + 12,
                spireOfDemID.mob.PROGENERATOR + 13,
                spireOfDemID.mob.PROGENERATOR + 14,
            },
        },

        spawned = false,
    },
}

return content:register()
