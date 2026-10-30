-----------------------------------
-- Area: Full Moon Fountain
-- Name: A Shantotto Ascension Mission 10, Battaru Royale
-- !pos -303 9.5 -260 170
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------
local fullMoonFountainID = zones[xi.zone.FULL_MOON_FOUNTAIN]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.FULL_MOON_FOUNTAIN,
    battlefieldId = xi.battlefield.id.BATTARU_ROYALE,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    timeLimit     = utils.minutes(30),
    index         = 3,
    entryNpc      = 'MS_Entrance',
    exitNpc       = 'Moon_Spiral',
    missionArea   = xi.mission.log_id.ASA,
    mission       = xi.mission.id.asa.BATTARU_ROYALE,

    grantXP = 700,
})

-- Every sap held is taken on entry. TODO: Capture needed, retail was only seen with all eight.
function content:entryRequirement(player, npc, isRegistrant, trade)
    return xi.asa.helpers.countKeyItems(player, xi.asa.helpers.sapCrystals) > 0
end

-- The fight stays open after the mission for another Chocobo key.
function content:checkRequirements(player, npc, isRegistrant, trade)
    if not Battlefield.checkRequirements(self, player, npc, isRegistrant, trade) then
        return false
    end

    return player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.BATTARU_ROYALE or
        player:hasCompletedMission(xi.mission.log_id.ASA, xi.mission.id.asa.BATTARU_ROYALE)
end

function content:onBattlefieldEnter(player, battlefield)
    local moonSpiral = GetNPCByID(fullMoonFountainID.npc.MS_ENTRANCE)
    if moonSpiral then
        player:messageText(moonSpiral, fullMoonFountainID.text.GREAT_STAR_TREE_RELEASED)
    end

    BattlefieldMission.onBattlefieldEnter(self, player, battlefield)

    xi.asa.helpers.delKeyItems(player, xi.asa.helpers.sapCrystals)
end

function content:onEventFinishWin(player, csid, option, npc)
    BattlefieldMission.onEventFinishWin(self, player, csid, option, npc)

    npcUtil.giveKeyItem(player, xi.keyItem.CHOCOBO_KEY)

    if player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.BATTARU_ROYALE then
        npcUtil.completeMission(player, xi.mission.log_id.ASA, xi.mission.id.asa.BATTARU_ROYALE,
        {
            nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.ROMANCING_THE_CLONE },
        })
    end
end

content.groups =
{
    {
        mobs =
        {
            'Clone_of_Flames',
            'Clone_of_Torrents',
            'Clone_of_Boulders',
            'Clone_of_Gusts',
            'Clone_of_Sparks',
            'Clone_of_Glaciers',
            'Clone_of_Lights',
            'Clone_of_Shadows',
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobs    = { 'Pet_Prime' },
        spawned = false,
    },
}

return content:register()
