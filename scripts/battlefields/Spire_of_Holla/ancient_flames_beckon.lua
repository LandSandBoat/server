-----------------------------------
-- Ancient Flames Beckon
-- Spire of Holla mission battlefield
-----------------------------------
require('scripts/missions/cop/helpers')
local spireOfHollaID = zones[xi.zone.SPIRE_OF_HOLLA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.SPIRE_OF_HOLLA,
    battlefieldId = xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_HOLLA,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 30,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = '_0h0',
    exitNpcs      = { '_0h1', '_0h2', '_0h3' },

    grantXP = 1500,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    local promathiaMission    = player:getCurrentMission(xi.mission.log_id.COP)
    local currentRequirements = promathiaMission == xi.mission.id.cop.BELOW_THE_ARKS or
        (promathiaMission == xi.mission.id.cop.THE_MOTHERCRYSTALS and not player:hasKeyItem(xi.ki.LIGHT_OF_HOLLA))
    local nonRegistrantReqs   = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) or currentRequirements

    return (not isRegistrant and nonRegistrantReqs) or currentRequirements
end

function content:checkSkipCutscene(player)
    return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) or
        player:hasKeyItem(xi.ki.LIGHT_OF_HOLLA)
end

function content:onBattlefieldWin(player, battlefield)
    local _, clearTime, partySize = battlefield:getRecord()

    local arg8        = xi.cop.helpers.numPromyvionCompleted(player, xi.cop.helpers.promyvionCrags.HOLLA) + 1
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
            { spireOfHollaID.mob.WREAKER     },
            { spireOfHollaID.mob.WREAKER + 1 },
            { spireOfHollaID.mob.WREAKER + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
