-----------------------------------
-- Journey to Windurst
-- San d'Oria M2-3 (Part 1)
-----------------------------------
-- !addmission 0 7
-- Kupipi    : !pos 2 0.1 30 242
-- Mourices  : !pos -50.646 -0.501 -27.642 241
-- Uu Zhoumo : !pos -179 16 155 145
-----------------------------------
local giddeusID = zones[xi.zone.GIDDEUS]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_WINDURST)

mission.reward = {}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GIDDEUS] =
        {
            ['Uu_Zhoumo'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SHIELD_OFFERING) then
                        return mission:progressEvent(42)
                    end
                end,
            },

            onEventFinish =
            {
                [42] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 6)
                    player:messageSpecial(giddeusID.text.OFFERED_UP_KEY_ITEM, xi.ki.SHIELD_OFFERING)
                    player:delKeyItem(xi.ki.SHIELD_OFFERING)
                end,
            },
        },

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 4 then
                        local needsSemihTrust = (not player:hasSpell(xi.magic.spell.SEMIH_LAFIHNA) and not player:findItem(xi.item.CIPHER_OF_SEMIHS_ALTER_EGO)) and 1 or 0

                        return mission:progressEvent(238, 1, 1, 1, 1, xi.nation.SANDORIA, 0, 0, needsSemihTrust)
                    elseif missionStatus == 5 then
                        return mission:event(240)
                    elseif missionStatus == 6 then
                        return mission:event(241)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return 42
                    end
                end,
            },

            onEventUpdate =
            {
                [42] = function(player, csid, option, npc)
                    local onPathUntraveled = player:getCurrentMission(xi.mission.log_id.ROV) == xi.mission.id.rov.THE_PATH_UNTRAVELED and 1 or 0

                    player:updateEvent(0, 0, 0, 0, 0, 0, 0, onPathUntraveled)
                end,
            },

            onEventFinish =
            {
                [ 42] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [238] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)
                    npcUtil.giveKeyItem(player, xi.ki.SHIELD_OFFERING)

                    if
                        not player:hasSpell(xi.magic.spell.SEMIH_LAFIHNA) and
                        not player:findItem(xi.item.CIPHER_OF_SEMIHS_ALTER_EGO)
                    then
                        npcUtil.giveItem(player, xi.item.CIPHER_OF_SEMIHS_ALTER_EGO)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Catalia'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) >= 3 then
                        return mission:progressEvent(452)
                    end
                end,
            },

            ['Erpolant'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) >= 3 then
                        return mission:progressEvent(454)
                    end
                end,
            },

            ['Forine'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) >= 3 then
                        return mission:progressEvent(453)
                    end
                end,
            },

            ['Mourices'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.item.PARANA_SHIELD, 2 } }) and
                        player:getMissionStatus(mission.areaId) == 6
                    then
                        return mission:progressEvent(457) -- Has delivered shield
                    end
                end,

                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus >= 3 and missionStatus <= 5 then
                        return mission:progressEvent(451)
                    elseif missionStatus == 6 then
                        return mission:progressEvent(456)
                    end
                end,
            },

            onEventFinish =
            {
                [457] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                        player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_ABROAD)
                        player:setMissionStatus(mission.areaId, 7)
                    end
                end,
            },
        },
    },
}

return mission
