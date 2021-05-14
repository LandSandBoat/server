-----------------------------------
-- Ark Angels
-- Zilart M14
-----------------------------------
-- !addmission 3 26
-- Gilgamesh          : !pos 122.452 -9.009 -12.052 252
-- blank_divine_might : !pos -40 0 -151 178
-- BCNM Entrances:
-- qm1_1 : !pos -605.063 -22.681 483.937 180
-- qm1_2 : !pos -264.782 -137.313 374.516 180
-- qm1_3 : !pos 14.148 -224.334 488.125 180
-- qm1_4 : !pos 235.650 -173.572 361.266 180
-- qm1_5 : !pos 555.998 -38.205 520.627 180
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/LaLoff_Amphitheater/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS)

-- Table index based on Battlefield ID - Offset, this ordering is different
-- from the keyItem table
local keyItemOffset =
{
    [0] = xi.ki.SHARD_OF_APATHY,
    [1] = xi.ki.SHARD_OF_COWARDICE,
    [2] = xi.ki.SHARD_OF_ENVY,
    [3] = xi.ki.SHARD_OF_ARROGANCE,
    [4] = xi.ki.SHARD_OF_RAGE,
}

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_SEALED_SHRINE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] = mission:event(171),
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.THE_SHRINE_OF_RUAVITAU] =
        {
            ['blank_divine_might'] = mission:progressEvent(53, 917, 1408, 1550),

            onEventFinish =
            {
                [53] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 1)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.LALOFF_AMPHITHEATER] = {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    -- Ark Angels and Divine Might are sequential, offset starts at 288
                    local keyItemIndex = player:getLocalVar("battlefieldWin") - 288

                    -- Single Fights
                    if keyItemIndex >= 0 and keyItemIndex <= 4 then
                        player:addKeyItem(keyItemOffset[keyItemIndex])
                        player:messageSpecial(ID.text.KEYITEM_OBTAINED, keyItemOffset[keyItemIndex])

                    -- Divine Might
                    elseif keyItemIndex == 5 then
                        for i = xi.ki.SHARD_OF_APATHY, xi.ki.SHARD_OF_RAGE do
                            player:addKeyItem(i)
                            player:messageSpecial(ID.text.KEYITEM_OBTAINED, i)
                        end

                        if player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT) == QUEST_ACCEPTED then
                            player:setCharVar("DivineMight", 2)
                        end
                    end

                    if
                        player:hasKeyItem(xi.ki.SHARD_OF_APATHY) and
                        player:hasKeyItem(xi.ki.SHARD_OF_ARROGANCE) and
                        player:hasKeyItem(xi.ki.SHARD_OF_COWARDICE) and
                        player:hasKeyItem(xi.ki.SHARD_OF_ENVY) and
                        player:hasKeyItem(xi.ki.SHARD_OF_RAGE)
                    then
                        player:setMissionStatus(xi.mission.log_id.ZILART, 0)
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
