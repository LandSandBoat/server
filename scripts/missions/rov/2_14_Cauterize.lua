-----------------------------------
-- Cauterize
-- Rhapsodies of Vana'diel Mission 2-14
-----------------------------------
-- !addmission 13 72
-- Cavernous Maws:
-- Batallia Downs           : !pos -48 0.1 435 105
-- Rolanberry Fields        : !pos -198 8 361 110
-- Sauromugue Champaign     : !pos 369 8 -227 120
-- Batallia Downs [S]       : !pos -48 0 435 84
-- Rolanberry Fields [S]    : !pos -198 8 360 91
-- Sauromugue Champaign [S] : !pos 369 8 -227 98
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.CAUTERIZE)

mission.reward =
{
    keyItem = xi.ki.LIGHTSWORM,
}

-- NOTE: No capture exists which causes the player to land on Uncertain Destinations. It
-- is possible that this requires absolutely no progress in WotG, and is not included in
-- the current implementation. Event parameters are implemented only based on the data
-- below, and may need to be updated in the future.

-- Requirements Note: Contrary to guides, this specific cutscene becomes available at
-- WotG M3 with Cait Sith available.  This CS does not display immediately after that mission
-- CS, and interaction is required with the QM.

-- Additional Note: Goblin Footprint displays various values (0..2) for the first parameter
-- which appears to not impact the CS.  Only the second parameter is consistent.  Params 2 and 3
-- change on

-- WotG Completed, TOAU Completed :  0, 2, 1 (Ganged Up On 3, Goblin Footprint, No Capture)
-- Current Mission WotG50         :  1, 1, 0
-- Current Mission WotG8          :  1, 0, 0
-- Current Mission WotG3          :  1, 0, 0

-- Default values for mission events.
local eventIdByZone =
{
    [xi.zone.BATALLIA_DOWNS]         = { 20, 0, 0, 0, utils.MAX_UINT32 - 1, 436377, 183, 624793, 21299 },
    [xi.zone.ROLANBERRY_FIELDS]      = { 18, 0, 0, 0, utils.MAX_UINT32 - 1, utils.MAX_UINT32 - 687432, utils.MAX_UINT32 - 1173, 32387, 0 },
    [xi.zone.SAUROMUGUE_CHAMPAIGN]   = { 19, 0, 0, 0, utils.MAX_UINT32 - 1, utils.MAX_UINT32 - 2049, utils.MAX_UINT32 - 1325423232, 1, 3871 },
    [xi.zone.BATALLIA_DOWNS_S]       = { 23, 0, 0, 0, utils.MAX_UINT32 - 1, 1996485631, 2147483519, 3, 0 },
    [xi.zone.ROLANBERRY_FIELDS_S]    = { 19, 0, 0, 0, utils.MAX_UINT32 - 1, 0, 1, 0, 7 },
    [xi.zone.SAUROMUGUE_CHAMPAIGN_S] = { 31, 0, 0, 0, utils.MAX_UINT32 - 1, 0, 4653057, 0, 1 },
}

local qmOnTrigger = function(player, npc)
    local zoneId = player:getZoneID()

    if xi.rhapsodies.charactersAvailable(player) then
        -- NOTE: Tables are userdata; make a copy of the desired row before modifying.
        local eventPack = { unpack(eventIdByZone[zoneId]) }

        eventPack[3] = player:getCurrentMission(xi.mission.log_id.WOTG) >= xi.mission.id.wotg.FORK_IN_THE_ROAD and 1 or 0

        return mission:progressEvent(unpack(eventPack))
    else
        local ID = zones[zoneId]

        return mission:messageSpecial(ID.text.UNABLE_TO_PROGRESS, 0, 2)
    end
end

local qmEventFinish = function(player, csid, option, npc)
    mission:complete(player)

    player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.UNCERTAIN_DESTINATIONS)
    player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.UNCERTAIN_DESTINATIONS)

    player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.GANGED_UP_ON)
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['qm_maw'] = qmOnTrigger,

            onEventFinish =
            {
                [20] = qmEventFinish,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS] =
        {
            ['qm_maw'] = qmOnTrigger,

            onEventFinish =
            {
                [18] = qmEventFinish,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN] =
        {
            ['qm_maw'] = qmOnTrigger,

            onEventFinish =
            {
                [19] = qmEventFinish,
            },
        },

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['qm_maw'] = qmOnTrigger,

            onEventFinish =
            {
                [23] = qmEventFinish,
            },
        },

        [xi.zone.ROLANBERRY_FIELDS_S] =
        {
            ['qm_maw'] = qmOnTrigger,

            onEventFinish =
            {
                [19] = qmEventFinish,
            },
        },

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['qm_maw'] = qmOnTrigger,

            onEventFinish =
            {
                [31] = qmEventFinish,
            },
        },
    },
}

return mission
