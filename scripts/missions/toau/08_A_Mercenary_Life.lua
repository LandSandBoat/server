-----------------------------------
-- A Mercenary Life
-- Aht Uhrgan Mission 8
-----------------------------------
-- !addmission 4 7
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.A_MERCENARY_LIFE)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.UNDERSEA_SCOUTING },
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
                    -- Option cycles between 2 and either a 1 or a 0.
                    local dialog = mission:getVar(player, 'Option')
                    if dialog == 2 then
                        -- Condition for Naja being friendly is unknown.
                        -- My character was a BLU with no mercenary rank and got friendly alt dialog.
                        local altOption = 0 -- 1 -> Friendly. 0 -> Not.
                        dialog = altOption
                    else
                        dialog = 2
                    end

                    mission:setVar(player, 'Option', dialog)

                    return mission:event(3029, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, dialog, 0)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                not mission:getMustZone(player)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            -- NOTE: Check Naja after zoning

            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    return mission:progressEvent(3050, 0, 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventUpdate =
            {
                [3050] = function(player, csid, option, npc)
                    -- Both topics must be selected before you can advance.
                    local dialogStatus = utils.mask.setBit(mission:getLocalVar(player, 'Dialog'), option - 1, true)
                    mission:setLocalVar(player, 'Dialog', dialogStatus)

                    player:updateEvent(dialogStatus, 1, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [3050] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
