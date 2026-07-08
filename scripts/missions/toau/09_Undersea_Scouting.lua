-----------------------------------
-- Undersea Scouting
-- Aht Uhrgan Mission 9
-----------------------------------
-- !addmission 4 8
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.UNDERSEA_SCOUTING)

mission.reward =
{
    keyItem     = xi.ki.ASTRAL_COMPASS,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.ASTRAL_WAVES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    local dialog = mission:getVar(player, 'Option')
                    if dialog == 0 then
                        mission:setVar(player, 'Option', 1)
                    else
                        mission:setVar(player, 'Option', 0)
                    end

                    return mission:event(3051, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, dialog, 0)
                end,
            },
        },

        [xi.zone.ALZADAAL_UNDERSEA_RUINS] =
        {
            onTriggerAreaEnter =
            {
                [23] = function(player, triggerArea)
                    return mission:progressEvent(1, xi.besieged.getMercenaryRank(player))
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
