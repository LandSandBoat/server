-----------------------------------
-- What Friends Are For
-- Region !pos -389 13 -445 68
-- Tsetseroon !pos -13 -6 69 53
-- Qm9 !pos -406 6.5 -440 68
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.WHAT_FRIENDS_ARE_FOR)

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 0
        end,

        [xi.zone.AYDEEWA_SUBTERRANE] = {
            ['qm9'] = {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                end,
            },
            onRegionEnter = {
                [2] = function(player, region)
                    return quest:progressEvent(7)
                end,
            },

            onEventFinish = {
                [7] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
        [xi.zone.NASHMAU] = {
            ['Tsetseroon'] = {
                onTrigger = function(player, npc)
                    return quest:event(4)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 1
        end,

        [xi.zone.NASHMAU] = {
            ['Tsetseroon'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(16)
                end,
            },

            onEventFinish = {
                [16] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:begin(player)
                end,
            },
        },
        [xi.zone.AYDEEWA_SUBTERRANE] = {
            ['qm9'] = {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NASHMAU] = {
            ['Tsetseroon'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:event(17)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:event(19)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(20)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Prog') == 2 and npcUtil.tradeHasExactly(trade, {xi.items.CHUNK_OF_TIN_ORE, xi.items.COBALT_JELLYFISH}) then
                        return quest:progressEvent(18)
                    end
                end,
            },

            onEventFinish = {
                [16] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:begin(player)
                end,
                [18] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.POT_OF_TSETSEROONS_STEW)
                    quest:setVar(player, 'Prog', 3)
                end,
                [20] = function(player, csid, option, npc)
                    if player:hasKeyItem(xi.ki.MAP_OF_AYDEEWA_SUBTERRANE) then
                        if npcUtil.giveItem(player, xi.items.IMPERIAL_BRONZE_PIECE) then
                            quest:complete(player)
                        end
                    else
                        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_AYDEEWA_SUBTERRANE)
                        quest:complete(player)
                    end
                end,
            },
        },
        [xi.zone.AYDEEWA_SUBTERRANE] = {
            ['qm9'] = {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 and player:hasKeyItem(xi.ki.POT_OF_TSETSEROONS_STEW) then
                        return quest:progressEvent(8)
                    else
                        return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,
            },
            onEventFinish = {
                [8] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    player:delKeyItem(xi.ki.POT_OF_TSETSEROONS_STEW)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.MAP_OF_AYDEEWA_SUBTERRANE)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.NASHMAU] = {
            ['Tsetseroon'] = {
                onTrigger = function(player, npc)
                    return quest:event(21)
                end,
            },
        },
        [xi.zone.AYDEEWA_SUBTERRANE] = {
            ['qm9'] = {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                end,
            },
        },
    },
}


return quest
