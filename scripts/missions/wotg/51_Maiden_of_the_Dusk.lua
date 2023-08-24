-----------------------------------
-- Maiden of the Dusk
-- Wings of the Goddess Mission 51
-----------------------------------
-- !addmission 5 50
-- Veridical Conflux : !pos -142.279 -6.749 585.239 89
-- Ornate Door       : !pos -700 -20.25 -303.398 89
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.MAIDEN_OF_THE_DUSK)

mission.reward =
{
    keyItem     = xi.ki.MOONSHADE_EARRING,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.WHERE_IT_ALL_BEGAN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Veridical_Conflux'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        local hasDeclined = mission:getVar(player, 'Option')

                        return mission:progressEvent(38, 89, 23, 1756, 0, 0, 0, hasDeclined, 0)
                    elseif not player:hasKeyItem(xi.ki.PRIMAL_GLOW) then
                        -- The wait for reobtaining this keyitem is only triggered after the initial
                        -- replacement.  It is possible that a timer is set on complete of last mission
                        -- for this piece, but unconfirmed.

                        if mission:getVar(player, 'Timer') <= VanadielUniqueDay() then
                            return mission:progressEvent(44, 89, 23, 1756, 0, 68032378, 209748094, 1, 0)
                        else
                            return mission:event(45, 89, 23, 1756, 0, 68032378, 209748094, 1, 0):oncePerZone()
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [38] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:setVar(player, 'Status', 1)
                        player:setPos(-700.042, 0.399, -441.301, 192, xi.zone.WALK_OF_ECHOES)
                    else
                        mission:setVar(player, 'Option', 1)
                    end
                end,

                [44] = function(player, csid, option, npc)
                    mission:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    npcUtil.giveKeyItem(player, xi.ki.PRIMAL_GLOW)
                end,
            },
        },

        [xi.zone.WALK_OF_ECHOES] =
        {
            ['_521'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: BCNM entry requires Primal Glow KI and Status variable set to 3.  BCNM
                    -- Event entry parameters observed: ID: 32000, Params: 0, 0, 383910532, 2
                    -- KeyItem is consumed on entry.

                    if mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(5)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 1 then
                        return 4
                    elseif missionStatus == 4 then
                        return 6
                    elseif missionStatus == 5 then
                        return 7
                    elseif missionStatus == 6 then
                        return 8
                    elseif missionStatus == 7 then
                        return 9
                    end
                end,
            },

            onEventUpdate =
            {
                [6] = function(player, csid, option, npc)
                    if option == 6 then
                        player:updateEvent(1, 300, 200, 100, 182, 1, 0, 0)
                    end
                end,

                [7] = function(player, csid, option, npc)
                    if option == 5 then
                        player:updateEvent(1, 300, 200, 100, 73, 545, 278, 0)
                    end
                end,

                [8] = function(player, csid, option, npc)
                    if option == 5 then
                        player:updateEvent(1, 300, 200, 100, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,

                [5] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                end,

                [6] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 5)
                    player:setPos(-700.063, -17.6, -331.903, 64, xi.zone.WALK_OF_ECHOES)
                end,

                [7] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 6)
                    player:setPos(-700.063, -17.6, -331.903, 64, xi.zone.WALK_OF_ECHOES)
                end,

                [8] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 7)
                    player:setPos(-700.063, -17.6, -331.903, 64, xi.zone.WALK_OF_ECHOES)
                end,

                [9] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [32001] = function(player, csid, option, npc)
                    -- TODO: Add battlefieldWin localvar check here, which should be set to battlefield
                    -- ID prior to this event being triggered in BCNM script.

                    mission:setVar(player, 'Status', 4)
                    player:setPos(-700.063, -17.6, -331.903, 64, xi.zone.WALK_OF_ECHOES)
                end,
            },
        },
    },
}

return mission
