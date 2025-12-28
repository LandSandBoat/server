-----------------------------------
-- President Salaheem
-- Aht Uhrgan Mission 3
-----------------------------------
-- !addmission 4 2
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PRESIDENT_SALAHEEM)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.KNIGHT_OF_GOLD },
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
                    if player:getMissionStatus(mission.areaId) == 1 then
                        if not mission:getMustZone(player) then
                            -- Trivia: There is a copy of this CS, but as a flashback, with Falzum instead of your character. CS: 3030
                            -- TODO: Maybe it's used?
                            return mission:progressEvent(3020, { text_table = 0 }) -- Enter Not-Trion.
                        else
                            return mission:event(3003, { [0] = xi.besieged.getMercenaryRank(player), text_table = 0 }) -- Default Dialog.
                        end
                    else
                        return mission:progressEvent(73, { text_table = 0 }) -- Mog Locker scam.
                    end
                end,
            },

            -- NOTE: Wikis are wrong, the CS with Rytaal is unlocked by this mission, but isn't needed at all to progress it.

            onEventFinish =
            {
                [73] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    mission:setMustZone(player)
                end,

                [3020] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
