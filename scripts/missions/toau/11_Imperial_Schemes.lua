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
                    local dialog = mission:getVar(player, 'Option') + 1 -- Captured values 1 and 2
                    if dialog == 1 then
                        mission:setVar(player, 'Option', 1)
                    else
                        mission:setVar(player, 'Option', 0)
                    end

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
                    if mission:complete(player) then
                        player:setCharVar('Mission[4][11]Timer', VanadielUniqueDay() + 1)
                        player:setLocalVar('Mission[4][11]mustZone', 1)
                    end
                end,
            },
        },
    },
}

return mission
