-----------------------------------
-- The New Frontier
-- Zilart M1
-----------------------------------
-- NOTE: xi.mission.id.zilart.THE_NEW_FRONTIER is set after the Nation 5-1 Shadow Lord Battle
-- !addmission 3 0
-- !setrank <name> 6
-- Norg : !zone 252
-- Tales' Beginning : !pos -25.784 1.097 -40.953 252
-----------------------------------
-- Zoning in at rank 6 plays event 1 as a short notice with a choice to watch the cutscene now or later.
-- Later reveals the Tales' Beginning at H-9 (event 293), which replays event 1 as the full cutscene.
-- The [ROZ]TalesBeginning charVar feeds the postponed-storyline bits in the mission log packet.
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER)

mission.reward =
{
    keyItem     = xi.ki.MAP_OF_NORG,
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.WELCOME_TNORG },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getRank(player:getNation()) >= 6
        end,

        [xi.zone.NORG] =
        {
            ['Tales_Beginning'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(293, 0, 0, 838927106, 157421318, 0, 4457218, 292556943, 0)
                end,
            },

            afterZoneIn = function(player)
                local norgID = zones[xi.zone.NORG]

                if player:getCharVar('[ROZ]TalesBeginning') == 0 then
                    return mission:progressEvent(1, 5, 0, 1751, 292583557, 1615226948, 424215298, 21487749, 8262)
                else
                    player:enableEntities({ norgID.npc.TALES_BEGINNING, norgID.npc.TALES_BEGINNING - 1 })
                end
            end,

            onEventUpdate =
            {
                [1] = function(player, csid, option, npc)
                    if player:getCharVar('[ROZ]TalesBeginning') == 0 then
                        -- The reply picks the short notice over the full cutscene.
                        player:updateEvent(79, VanadielTime(), 0, 0, 0, utils.MAX_UINT32, 9044486, 0)
                    else
                        -- The reply picks the full cutscene.
                        player:updateEvent(65, 0, 838927106, 1, 0, 4457218, 292556943, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    -- Maybe later. The storyline is postponed until started at the Tales' Beginning.
                    if option == 0 and player:getCharVar('[ROZ]TalesBeginning') == 0 then
                        local norgID = zones[xi.zone.NORG]

                        player:setCharVar('[ROZ]TalesBeginning', 1)
                        player:sendPartialMissionLog(xi.mission.log_id.ZILART, false)
                        player:enableEntities({ norgID.npc.TALES_BEGINNING, norgID.npc.TALES_BEGINNING - 1 })
                    -- The full cutscene played, at once (option 1) or from the Tales' Beginning.
                    elseif option == 1 or option == 0 then
                        if player:getCharVar('[ROZ]TalesBeginning') > 0 then
                            player:setCharVar('[ROZ]TalesBeginning', 0)
                            player:enableEntities({})
                        end

                        mission:complete(player)
                    end
                end,

                [293] = function(player, csid, option, npc)
                    if option == 1 then
                        player:startEvent(1, 252, 0, 838927106, 1, 0, 4457218, 292556943, 0)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.NORG] =
        {
            ['_700']       = mission:event(5):replaceDefault(),
            ['Comitiolus'] = mission:event(6):replaceDefault(),
        },
    },
}

return mission
