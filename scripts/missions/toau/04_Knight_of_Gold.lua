-----------------------------------
-- Knight of Gold
-- Aht Uhrgan Mission 4
-----------------------------------
-- !addmission 4 3
-- Cacaroon       : !pos -72  0  -86 50
-- Walahra Temple : !pos  80 -0.3 22 50
-- Teahouse       : !pos  80 -6 -117 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.KNIGHT_OF_GOLD)

mission.reward =
{
    keyItem     = xi.ki.RAILLEFALS_LETTER,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.CONFESSIONS_OF_ROYALTY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Cacaroon'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        (npcUtil.tradeMatches(trade, { { xi.item.GIL, 1000 } }) or
                        npcUtil.tradeMatches(trade, { { xi.item.IMPERIAL_BRONZE_PIECE, 1 } }))
                    then
                        return mission:progressEvent(3022, { text_table = 0 })
                    end
                end,

                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus <= 1 then
                        local param6 = 0 -- Can trigger a line "weirdo with silly mask". Maybe tied to RoV?

                        return mission:progressEvent(3035, 0, 0, 0, 0, 0, param6, 0, missionStatus, 0)
                    elseif missionStatus == 2 then
                        return mission:event(3036, { text_table = 0 })
                    else
                        return mission:event(3023, { text_table = 0 })
                    end
                end,
            },

            ['Nadeey'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) >= 3 then
                        return mission:event(3025, { text_table = 0 })
                    end
                end,
            },

            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(3021, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onTriggerAreaEnter =
            {
                [4] = function(player, triggerArea)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:progressEvent(3024, { text_table = 0 })
                    end
                end,

                [5] = function(player, triggerArea)
                    if player:getMissionStatus(mission.areaId) == 4 then
                        local param6 = 0 -- Mention "San d'Oria's legendary sword". Maybe tied to RoV?

                        return mission:progressEvent(3026, 0, 0, 0, 0, 0, param6, 0, 0, 0)
                    end
                end,
            },

            onEventUpdate =
            {
                [3026] = function(player, csid, option, npc)
                    -- First option is always 10. Then it's 1, 2, or 3 based on selection.
                    -- All 3 topics must be selected before you can advance.
                    local bit    = utils.clamp(option, 1, 4) - 1
                    local topics = utils.mask.setBit(mission:getLocalVar(player, 'Option'), bit, true)
                    mission:setLocalVar(player, 'Option', topics)

                    player:updateEvent(topics, 1)
                end,
            },

            onEventFinish =
            {
                -- Step 2: Cacaroon trade event.
                [3022] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:setMissionStatus(mission.areaId, 3)
                end,

                -- Step 3: Zone-in event.
                [3024] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                -- Step 4: Zone-in event.
                [3026] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                -- Step 1: Cacaroon trigger event.
                [3035] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setMissionStatus(mission.areaId, 1)
                    else
                        player:setMissionStatus(mission.areaId, 2)
                    end
                end,
            },
        },
    },
}

return mission
