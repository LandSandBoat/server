-----------------------------------
-- Imperial Schemes
-- Aht Uhrgan Mission 11
-----------------------------------
-- !addmission 4 10
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.IMPERIAL_SCHEMES)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.ROYAL_PUPPETEER },
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

                    return mission:event(3053, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, dialog, 0)
                end,
            },

            onTriggerAreaEnter =
            {
                [6] = function(player, triggerArea)
                    if
                        not mission:getMustZone(player) and
                        VanadielUniqueDay() >= mission:getVar(player, 'Timer')
                    then
                        return mission:progressEvent(3070, { text_table = 0 })
                    end
                end,
            },

            onEventUpdate =
            {
                [3070] = function(player, csid, option, npc)
                    if option == 2 then
                        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 4)
                    end
                end,
            },

            onEventFinish =
            {
                [3070] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
