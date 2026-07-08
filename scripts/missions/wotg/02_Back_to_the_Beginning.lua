-----------------------------------
-- Back to the Beginning
-- Wings of the Goddess Mission 2
-----------------------------------
-- !addmission 5 1
-- FIRES_OF_DISCONTENT  : !completequest 7 13
-- CLAWS_OF_THE_GRIFFON : !completequest 7 16
-- THE_TIGRESS_STRIKES  : !completequest 7 18
-- Cavernous Maws:
-- Batallia Downs           : !pos -48 0.1 435 105
-- Rolanberry Fields        : !pos -198 8 361 110
-- Sauromugue Champaign     : !pos 369 8 -227 120
-- Batallia Downs [S]       : !pos -48 0 435 84
-- Rolanberry Fields [S]    : !pos -198 8 360 91
-- Sauromugue Champaign [S] : !pos 369 8 -227 98
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.BACK_TO_THE_BEGINNING)

mission.reward =
{
    keyItem     = xi.ki.LIGHTSWORM,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.CAIT_SITH },
}

local mawEvents =
{
    [xi.zone.BATALLIA_DOWNS]         = { 501, 0, 1 },
    [xi.zone.ROLANBERRY_FIELDS]      = { 501, 1, 1 },
    [xi.zone.SAUROMUGUE_CHAMPAIGN]   = { 501, 2, 1 },
    [xi.zone.BATALLIA_DOWNS_S]       = { 701, 0, 1 },
    [xi.zone.ROLANBERRY_FIELDS_S]    = { 701, 1, 1 },
    [xi.zone.SAUROMUGUE_CHAMPAIGN_S] = { 701, 2, 1 },
}

local function mawEvent(zoneId)
    return mission:progressEvent(unpack(mawEvents[zoneId]))
end

local function completeMission(player, csid, option, npc)
    if mission:complete(player) then
        xi.maws.addMaw(player)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                xi.wotg.helpers.meetsMission3Reqs(player)
        end,

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['Cavernous_Maw'] = mawEvent(xi.zone.BATALLIA_DOWNS),

            onEventFinish =
            {
                [501] = completeMission,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS] =
        {
            ['Cavernous_Maw'] = mawEvent(xi.zone.ROLANBERRY_FIELDS),

            onEventFinish =
            {
                [501] = completeMission,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN] =
        {
            ['Cavernous_Maw'] = mawEvent(xi.zone.SAUROMUGUE_CHAMPAIGN),

            onEventFinish =
            {
                [501] = completeMission,
            },
        },

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Cavernous_Maw'] = mawEvent(xi.zone.BATALLIA_DOWNS_S),

            onEventFinish =
            {
                [701] = completeMission,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS_S] =
        {
            ['Cavernous_Maw'] = mawEvent(xi.zone.ROLANBERRY_FIELDS_S),

            onEventFinish =
            {
                [701] = completeMission,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Cavernous_Maw'] = mawEvent(xi.zone.SAUROMUGUE_CHAMPAIGN_S),

            onEventFinish =
            {
                [701] = completeMission,
            },
        },
    },
}

return mission
