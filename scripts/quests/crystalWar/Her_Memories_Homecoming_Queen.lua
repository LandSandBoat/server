-----------------------------------
-- Her Memories: Homecoming Queen
-----------------------------------
-- !addquest 7 64
-- Thierride  : !pos -67 -5 -28 232
-- Amaura     : !pos -84.367 -6.949 91.148 230
-- Abioleget  : !pos 128.771 0.000 118.538 231
-- Bertenont  : !pos -165 0.1 226 231
-- Halver     : !pos 2 0.1 0.1 233
-- Gravestone : !pos 149.728 -5.109 -395.121 105
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/quest')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/missions/wotg/helpers')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_HOMECOMING_QUEEN)

quest.reward =
{
    keyItem = xi.ki.LARGE_MEMORY_FRAGMENT1,
}

local subQuestData =
{
    [793] = { xi.quest.id.crystalWar.HER_MEMORIES_OLD_BEAN,          xi.ki.TINY_MEMORY_FRAGMENT1 },
    [870] = { xi.quest.id.crystalWar.HER_MEMORIES_THE_FAUX_PAS,      xi.ki.TINY_MEMORY_FRAGMENT2 },
    [6  ] = { xi.quest.id.crystalWar.HER_MEMORIES_THE_GRAVE_RESOLVE, xi.ki.TINY_MEMORY_FRAGMENT3 },
}

local function handleQuestCompletion(player, csid, option, npc)
    local ID = zones[player:getZoneID()]
    local numKeyItems = 0

    for _, questData in pairs(subQuestData) do
        if player:hasKeyItem(questData[2]) then
            numKeyItems = numKeyItems + 1
        end
    end

    player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, subQuestData[csid][1])

    if numKeyItems < 2 then
        player:messageName(ID.text.FRAGMENT_FAR_TOO_SMALL, nil, subQuestData[csid][2])
        npcUtil.giveKeyItem(player, subQuestData[csid][2])
    else
        player:messageSpecial(ID.text.FRAGMENTS_MELD, xi.ki.LARGE_MEMORY_FRAGMENT1)

        for _, questData in pairs(subQuestData) do
            player:delKeyItem(questData[2])
        end

        xi.wotg.helpers.checkMemoryFragments(player)

        quest:complete(player)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.WOTG) == xi.mission.id.wotg.HER_MEMORIES
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.EAST_RONFAURE then
                        return 957
                    end
                end,
            },

            onEventFinish =
            {
                [957] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Her Memories: Old Bean
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_OLD_BEAN) ~= QUEST_COMPLETED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Thierride'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog1')

                    if questProgress == 0 then
                        if not player:hasKeyItem(xi.ki.THIERRIDES_BEAN_CREATION) then
                            return quest:progressEvent(792)
                        else
                            return quest:event(794):oncePerZone()
                        end
                    elseif questProgress == 1 then
                        return quest:progressEvent(793)
                    end
                end,
            },

            onEventFinish =
            {
                [792] = function(player, csid, option, npc)
                    player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_OLD_BEAN)

                    npcUtil.giveKeyItem(player, xi.ki.THIERRIDES_BEAN_CREATION)
                end,

                [793] = handleQuestCompletion,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.THIERRIDES_BEAN_CREATION) then
                        return quest:progressEvent(958, 650067949, 0, 5, 0, 156286100, 100000, 4095, 131073)
                    elseif quest:getVar(player, 'Prog1') == 1 then
                        return quest:event(959):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [958] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.THIERRIDES_BEAN_CREATION)

                    quest:setVar(player, 'Prog1', 1)
                end,
            },
        },
    },

    -- Her Memories: The Faux Pas
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_THE_FAUX_PAS) ~= QUEST_COMPLETED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Abioleget'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog2') == 0 then
                        return quest:progressEvent(869)
                    else
                        return quest:event(871):oncePerZone()
                    end
                end,
            },

            ['Bertenont'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog2') == 1 then
                        return quest:progressEvent(870)
                    end
                end,
            },

            onEventFinish =
            {
                [869] = function(player, csid, option, npc)
                    player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_THE_FAUX_PAS)

                    quest:setVar(player, 'Prog2', 1)
                end,

                [870] = handleQuestCompletion,
            },
        },
    },

    -- Her Memories: The Grave Resolve
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_THE_GRAVE_RESOLVE) ~= QUEST_COMPLETED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog3') == 0 then
                        return quest:progressEvent(571, 65, 23, 2964, 100000, 233714167, 0, 1, 0)
                    else
                        return quest:event(572, 69, 23, 2964, 100000, 233714167, 0, 1, 0):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [571] = function(player, csid, option, npc)
                    player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_THE_GRAVE_RESOLVE)

                    quest:setVar(player, 'Prog3', 1)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['Weathered_Gravestone'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.LILAC) and
                        quest:getVar(player, 'Prog3') == 2
                    then
                        player:confirmTrade()

                        return quest:progressEvent(6, 119, 300, 200, 100, 0, 0, 558716, 0)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog3') >= 1 then
                        return quest:progressEvent(5, 105, 0, 0, 0, 43, 0, 558716, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog3', 2)
                end,

                [6] = handleQuestCompletion,
            },
        },
    },
}

return quest
