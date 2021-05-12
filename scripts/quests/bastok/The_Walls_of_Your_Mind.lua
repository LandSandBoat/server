-----------------------------------
-- The Walls of Your Mind
-- Oggbi !pos -159 -7 5 236
-- qm1 !pos 20 17 -140 167
-----------------------------------
require("scripts/globals/interaction/quest")
require("scripts/globals/weaponskillids")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------
local portBastokID = require("scripts/zones/Port_Bastok/IDs")
local bostaunieuxID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WALLS_OF_YOUR_MIND)

quest.reward = {
    fame = 30,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:canEquipItem(xi.items.KNUCKLES_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.HAND_TO_HAND) / 10 >= 250 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.PORT_BASTOK] = {
            ['Oggbi'] = {
                onTrigger = function(player, npc)
                    return quest:event(286):oncePerZone() -- start
                end,
            },

            onEventFinish = {
                [286] = function(player, csid, option, npc)
                    if player:hasItem(xi.items.KNUCKLES_OF_TRIALS) or npcUtil.giveItem(player, xi.items.KNUCKLES_OF_TRIALS) then
                        npcUtil.giveKeyItem(player, xi.keyItem.WEAPON_TRAINING_GUIDE)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] = {
            ['Oggbi'] = {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(290)
                    else
                        local hideReacquireMenuItem = (player:hasItem(xi.items.KNUCKLES_OF_TRIALS) or player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)) and 1 or 0
                        return quest:event(287, hideReacquireMenuItem)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.KNUCKLES_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(288)
                        else
                            return quest:progressEvent(289)
                        end
                    end
                end,
            },

            onEventFinish = {
                [287] = function(player, csid, option, npc)
                    if option == 1 and not player:hasItem(xi.items.KNUCKLES_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.items.KNUCKLES_OF_TRIALS)
                    elseif option == 2 then
                        player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WALLS_OF_YOUR_MIND)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [289] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [290] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                    player:addLearnedWeaponskill(xi.ws_unlock.ASURAN_FISTS)
                    player:messageSpecial(portBastokID.text.ASURAN_FISTS_LEARNED)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        player:addKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        return quest:messageSpecial(bostaunieuxID.text.KEYITEM_OBTAINED, xi.ki.ANNALS_OF_TRUTH)
                    elseif
                        player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and
                        not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and
                        npcUtil.popFromQM(player, npc, bostaunieuxID.mob.BODACH, {hide = 0})
                    then
                        return quest:messageSpecial(bostaunieuxID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Bodach'] = {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    player:setLocalVar('killed_wsnm', 1)
                end,
            },
        },
    },
}

return quest
