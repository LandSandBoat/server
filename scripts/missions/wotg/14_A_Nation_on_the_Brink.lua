-----------------------------------
-- A Nation on the Brink
-- Wings of the Goddess Mission 14
-----------------------------------
-- !addmission 5 13
-- Underpass_Hatch : !pos 314.083 -1.160 -181.455 84
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.A_NATION_ON_THE_BRINK)

mission.reward =
{
    title       = xi.ki.BATTLE_OF_JEUNO_VETERAN,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.CROSSROADS_OF_TIME },
}

mission.sections =
{
    -- 0. Go to Batallia Downs (S) and check the Underpass Hatch in the top right corner of (J-9), in one of the towers, for a cutscene.
    -- The staircase is to the south of your arrival point if you teleported via Campaign Arbiter.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.BATALLIA_DOWNS_S] =
        {
            ['Underpass_Hatch'] =
            {
                onTrigger = function(player, npc)
                    -- NOTE: "The CS"!
                    -- TODO: What are these args from caps?
                    return mission:progressEvent(3, 24, 5, 0, 120, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- 1. Check the Underpass Hatch again while in possession of an Key ItemUnderpass Hatch Key to begin the battlefield in Everbloom Hollow.
    -- TODO
    -- Instance entry to Everbloom Hollow

    -- Post Instance:
    -- CS 4 (no args)
    -- Event option: 1
    -- Event update: 2, 0, 2963
    -- Event option: 1
    -- Zone CS: 20
    -- Zone CS: 21
    -- Zone CS: 22

    -- Obtain Jeunoan Flag
    -- Complete mission

    -- Maybe if you can't get the item, you can get it through a Mystic Retreiver, since those CSs are so long?
}

return mission
