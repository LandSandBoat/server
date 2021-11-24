-----------------------------------
-- Hitting the Marquisate
-----------------------------------
-- !addquest 2 71
-- Nanaa Mihgo     : !pos 62 -4 240 241
-- Yatniel         : !pos -66.817 -7 -126.594 245
-- Hagain          : !pos 19.847 -0.105 -1.945 249
-- qm6 (???)       : !pos -220.039 -5.500 194.192 200
-- qm5 (???)       : !pos -259.927 -5.500 194.410 200
-- qm12 (???)      : !pos -245.603 -5.500 139.855 200
-- qm13 (???)      : !pos -194.166 -5.500 139.969 200
-- qm10 (???)      : !pos -139.895 -5.500 154.513 200
-- qm9 (???)       : !pos -140.039 -5.500 285.999 200
-- qm15 (???)      : !pos 19.893 -5.500 325.767 200
-- qm2 (La Theine) : !pos -72.99 54.599 -443.126 102
-- NOTE: Garlaige QM order is based on quest progression
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/status')
require('scripts/globals/zone')
-----------------------------------
local garlaigeID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HITTING_THE_MARQUISATE)

quest.reward =
{
    item  = xi.items.ROGUES_POULAINES,
    title = xi.title.PARAGON_OF_THIEF_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                not quest:getMustZone(player) and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES) and
                player:getMainJob() == xi.job.THF and
                player:getMainLvl() >= xi.settings.AF3_QUEST_LEVEL
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] = quest:progressEvent(512),

            onEventFinish =
            {
                [512] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.CAT_BURGLARS_NOTE)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.GARLAIGE_CITADEL] =
        {
            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.BOMB_INCENSE) and
                        quest:getVar(player, 'hagainProg') == 2
                    then
                        player:messageSpecial(garlaigeID.text.PRESENCE_FROM_CEILING)
                        return quest:progressEvent(51, xi.ki.BOMB_INCENSE)
                    end
                end,
            },

            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.BOMB_INCENSE) and
                        quest:getVar(player, 'hagainProg') == 1
                    then
                        player:messageSpecial(garlaigeID.text.PRESENCE_FROM_CEILING)
                        return quest:progressEvent(50, xi.ki.BOMB_INCENSE)
                    end
                end,
            },

            ['qm9'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.BOMB_INCENSE) and
                        quest:getVar(player, 'hagainProg') == 6
                    then
                        player:messageSpecial(garlaigeID.text.PRESENCE_FROM_CEILING)
                        return quest:progressEvent(55, xi.ki.BOMB_INCENSE)
                    end
                end,
            },

            ['qm10'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.BOMB_INCENSE) and
                        quest:getVar(player, 'hagainProg') == 5
                    then
                        player:messageSpecial(garlaigeID.text.PRESENCE_FROM_CEILING)
                        return quest:progressEvent(54, xi.ki.BOMB_INCENSE)
                    end
                end,
            },

            ['qm12'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.BOMB_INCENSE) and
                        quest:getVar(player, 'hagainProg') == 3
                    then
                        player:messageSpecial(garlaigeID.text.PRESENCE_FROM_CEILING)
                        return quest:progressEvent(52, xi.ki.BOMB_INCENSE)
                    end
                end,
            },

            ['qm13'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.BOMB_INCENSE) and
                        quest:getVar(player, 'hagainProg') == 4
                    then
                        player:messageSpecial(garlaigeID.text.PRESENCE_FROM_CEILING)
                        return quest:progressEvent(53, xi.ki.BOMB_INCENSE)
                    end
                end,
            },

            ['qm15'] =
            {
                onTrigger = function(player, npc)
                    local hagainProgress = quest:getVar(player, 'hagainProg')

                    if hagainProgress == 7 then
                        if
                            os.time() <= GetNPCByID(garlaigeID.npc.CHANDELIER_QM):getLocalVar("chandelierCooldown")
                        then
                            return quest:messageSpecial(garlaigeID.text.THE_PRESENCE_MOVES + 7)
                        elseif
                            not GetMobByID(garlaigeID.mob.CHANDELIER):isSpawned() and
                            player:hasKeyItem(xi.ki.BOMB_INCENSE)
                        then
                            player:messageSpecial(garlaigeID.text.HEAT_FROM_CEILING)
                            return quest:progressEvent(56, xi.keyItem.BOMB_INCENSE)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(garlaigeID.text.THE_PRESENCE_MOVES + 1) -- Presence moved west.
                        quest:setVar(player, 'hagainProg', 2)
                    end
                end,

                [51] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(garlaigeID.text.THE_PRESENCE_MOVES + 2) -- Presence moved south.
                        quest:setVar(player, 'hagainProg', 3)
                    end
                end,

                [52] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(garlaigeID.text.THE_PRESENCE_MOVES) -- Presence moved east.
                        quest:setVar(player, 'hagainProg', 4)
                    end
                end,

                [53] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(garlaigeID.text.THE_PRESENCE_MOVES) -- Presence moved east.
                        quest:setVar(player, 'hagainProg', 5)
                    end
                end,

                [54] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(garlaigeID.text.THE_PRESENCE_MOVES + 3) -- Presence moved north.
                        quest:setVar(player, 'hagainProg', 6)
                    end
                end,

                [55] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(garlaigeID.text.THE_PRESENCE_MOVES) -- Presence moved east.
                        quest:setVar(player, 'hagainProg', 7)
                    end
                end,

                [56] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(garlaigeID.text.THE_PRESENCE_MOVES + 5) -- Something flies out from the ceiling!
                        GetMobByID(garlaigeID.mob.CHANDELIER):setRespawnTime(5)
                    else
                        player:messageSpecial(garlaigeID.text.THE_PRESENCE_MOVES + 6) -- The presence in the ceiling still lingers...
                    end
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['qm2'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.PICKAXE) and
                        quest:getVar(player, 'nanaaProg') == 1
                    then
                        return quest:progressEvent(119, 0, 0, 0, xi.items.PICKAXE)
                    end
                end,
            },

            onEventFinish =
            {
                [119] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:delKeyItem(xi.ki.CAT_BURGLARS_NOTE)
                    end
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Yatniel'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, {{ xi.items.QUAKE_GRENADE, 4 }})
                    then
                        return quest:progressEvent(10031)
                    end
                end,

                onTrigger = function(player, npc)
                    local yatnielProgress = quest:getVar(player, 'yatnielProg')

                    if yatnielProgress == 0 then
                        return quest:progressEvent(10029, 0, xi.items.QUAKE_GRENADE)
                    elseif yatnielProgress == 1 then
                        return quest:progressEvent(10030, 0, xi.items.QUAKE_GRENADE)
                    elseif yatnielProgress == 2 then
                        return quest:progressEvent(10032)
                    end
                end,
            },

            onEventFinish =
            {
                [10029] = function(player, csid, option, npc)
                    quest:setVar(player, 'yatnielProg', 1)
                end,

                [10031] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'yatnielProg', 2)
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            ['Hagain'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.LUMP_OF_CHANDELIER_COAL) then
                        return quest:progressEvent(10005)
                    end
                end,

                onTrigger = function(player, npc)
                    local hagainProgress = quest:getVar(player, 'hagainProg')

                    if hagainProgress == 0 then
                        return quest:progressEvent(10003, 0, xi.ki.BOMB_INCENSE, xi.items.LUMP_OF_CHANDELIER_COAL)
                    elseif hagainProgress == 8 then
                        return quest:progressEvent(10006)
                    else
                        return quest:progressEvent(10004, 0, xi.ki.BOMB_INCENSE, xi.items.LUMP_OF_CHANDELIER_COAL)
                    end
                end,
            },

            onEventFinish =
            {
                [10003] = function(player, csid, option, npc)
                    quest:setVar(player, 'hagainProg', 1)
                    npcUtil.giveKeyItem(player, xi.ki.BOMB_INCENSE)
                end,

                [10005] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:delKeyItem(xi.ki.BOMB_INCENSE)
                    quest:setVar(player, 'hagainProg', 8)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'yatnielProg') == 2 and
                        quest:getVar(player, 'hagainProg') == 8
                    then
                        return quest:progressEvent(516)
                    elseif quest:getVar(player, 'nanaaProg') == 1 then
                        return quest:progressEvent(517)
                    end
                end,
            },

            onEventFinish =
            {
                [516] = function(player, csid, option, npc)
                    quest:setVar(player, 'nanaaProg', 1)
                    quest:setVar(player, 'yatnielProg', 0)
                    quest:setVar(player, 'hagainProg', 0)
                end,
            },
        },
    },
}

return quest
