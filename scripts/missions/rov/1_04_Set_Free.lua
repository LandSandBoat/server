-----------------------------------
-- Emissary from the Seas
-- Rhapsodies of Vana'diel Mission 1-4
-----------------------------------
-- !addmission 13 4
-- Abelard : !pos -52 -11 -13 248
-- Ekokoko : !pos -78 -24 28 249
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.SET_FREE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_BEGINNING },
}

local handleTradeEventFinish = function(player, csid, option, npc)
    if not player:hasJob(0) then
        npcUtil.giveKeyItem(player, xi.ki.GILGAMESHS_INTRODUCTORY_LETTER)
    else
        if not npcUtil.giveItem(player, xi.items.COPPER_AMAN_VOUCHER) then
            -- Do not complete mission or confirm trade if the player is not
            -- able to receive the reward.  Instead, bail out here.
            return
        end
    end

    local pathId = player:getMissionStatus(mission.areaId)

    player:confirmTrade()
    mission:complete(player)
    player:setMissionStatus(mission.areaId, pathId)
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SELBINA] =
        {
            ['Abelard'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.items.CLUMP_OF_BEE_POLLEN, 3 } }) and
                        player:getMissionStatus(mission.areaId) == 1
                    then
                        return mission:progressEvent(178, 0, 0, 0, 0, 0, 0, player:hasJob(0) and 1 or 0)
                    end
                end,

                onTrigger = function(player, npc)
                    return mission:event(181):importantOnce()
                end,
            },

            onEventFinish =
            {
                [178] = handleTradeEventFinish,
            },
        },

        [xi.zone.MHAURA] =
        {
            ['Ekokoko'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.items.MANDRAGORA_DEWDROP, 3 } }) and
                        player:getMissionStatus(mission.areaId) == 2
                    then
                        return mission:progressEvent(370, 0, 0, 0, 0, 0, 0, player:hasJob(0) and 1 or 0)
                    end
                end,

                onTrigger = function(player, npc)
                    return mission:event(373):importantOnce()
                end,
            },

            -- TODO: There may be reminder dialog here, need captures to confirm (Possibly Event 369)

            onEventFinish =
            {
                [370] = handleTradeEventFinish,
            },
        },
    },
}

return mission
