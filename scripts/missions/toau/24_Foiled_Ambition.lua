-----------------------------------
-- Foiled Ambition
-- Aht Uhrgan Mission 24
-----------------------------------
-- !addmission 4 23
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.FOILED_AMBITION)

mission.reward =
{
    item        = { { xi.item.IMPERIAL_GOLD_PIECE, 5 } },
    title       = xi.title.KARABABAS_SECRET_AGENT,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.PLAYING_THE_PART },
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
                    return mission:event(3096, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 1, 0, 2, 0)
                end,
            },

            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    if
                        not mission:getMustZone(player) and
                        VanadielUniqueDay() >= mission:getVar(player, 'Timer')
                    then
                        return mission:progressEvent(3097, { text_table = 0 })
                    end
                end,
            },

            onEventUpdate =
            {
                [3097] = function(player, csid, option, npc)
                    player:updateEvent(78, 1, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [3097] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setLocalVar('Mission[4][24]mustZone', 1)
                        player:setCharVar('Mission[4][24]Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
