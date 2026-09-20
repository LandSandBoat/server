-----------------------------------
-- Passing Glory
-- Aht Uhrgan Mission 18
-----------------------------------
-- !addmission 4 17
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PASSING_GLORY)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.SWEETS_FOR_THE_SOUL },
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
                    if
                        not mission:getMustZone(player) and
                        VanadielUniqueDay() >= mission:getVar(player, 'Timer')
                    then
                        return mission:progressEvent(3090, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                    else
                        -- Option cycles between 2 and either a 1 or a 0.
                        local dialog = mission:getVar(player, 'Option')
                        if dialog == 2 then
                            -- Condition for Naja being friendly is unknown. Probably the same as ToAU 8.
                            local altOption = 0 -- 1 -> Friendly. 0 -> Not.
                            dialog = altOption
                        else
                            dialog = 2
                        end

                        mission:setVar(player, 'Option', dialog)

                        return mission:event(3079, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, dialog, 0)
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    if
                        not mission:getMustZone(player) and
                        VanadielUniqueDay() >= mission:getVar(player, 'Timer')
                    then
                        return mission:progressEvent(3090, { text_table = 0 })
                    end
                end,
            },

            onEventUpdate =
            {
                [3090] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 1, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [3090] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
