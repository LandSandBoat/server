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
                    -- Order goes 1 -> 0 -> 1 -> 0 ...
                    local dialog = mission:getVar(player, 'Option') == 0 and 1 or 0
                    mission:setVar(player, 'Option', dialog)

                    return mission:event(3051, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, dialog, 0)
                end,
            },
        },

        [xi.zone.ALZADAAL_UNDERSEA_RUINS] =
        {
            onTriggerAreaEnter =
            {
                [23] = function(player, triggerArea)
                    local param3 = 0 -- Mentions, "Hey, it's you!" Maybe tied to PUP?

                    return mission:progressEvent(1, xi.besieged.getMercenaryRank(player), param3)
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
