-----------------------------------
-- Dungeons and Dancers
-- Wings of the Goddess Mission 23
-----------------------------------
-- !addmission 5 22
-- Regal Pawprints (G-9) : !pos -145.266 -61.851 -174.171 136
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.DUNGEONS_AND_DANCERS)

mission.reward =
{
    keyItem     = xi.ki.UMBRA_BUG,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.DISTORTER_OF_TIME },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BEAUCEDINE_GLACIER_S] =
        {
            ['Regal_Pawprints_8'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(20, 36, 5, 1756)
                    end
                end,
            },

            ['Regal_Pawprints_1'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.AROMA_BUG) and
                        mission:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        -- TODO: For future Instance implementation, on instance fail,
                        -- Timer var should be set to VanadielUniqueDay() + 1

                        return mission:progressEvent(25, 136, 23, 1756, 0, 0, 7995412, 0, 0)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        return 18
                    end
                end,
            },

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [20] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [25] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.AROMA_BUG)
                end,
            },
        },

        [xi.zone.EVERBLOOM_HOLLOW] =
        {
            onEventFinish =
            {
                [10000] = function(player, csid, option, npc)
                    -- TODO: The assumption for this mission script is to catch Event 10000 which is
                    -- sent once the battlefield has been cleared.  This needs to be verified upon
                    -- implementation of the instance.

                    mission:setVar(player, 'Status', 2)
                    player:setPos(-148.078, -61.320, -176.608, 32, xi.zone.BEAUCEDINE_GLACIER_S)
                end,
            },
        },
    },
}

return mission
