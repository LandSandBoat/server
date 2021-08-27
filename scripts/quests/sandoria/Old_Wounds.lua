-----------------------------------
-- Old Wounds
-- Curilla !pos 27 0.1 0.1 233
-- qm3 !pos -145 2 446 208
-----------------------------------
require("scripts/globals/interaction/quest")
require("scripts/globals/weaponskillids")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------
local chateauID = require("scripts/zones/Chateau_dOraguille/IDs")
local quicksandCavesID = require("scripts/zones/Quicksand_Caves/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.OLD_WOUNDS)

quest.reward = {
    fame = 30,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:canEquipItem(xi.items.SAPARA_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.SWORD) / 10 >= 240 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.CHATEAU_DORAGUILLE] = {
            ['Curilla'] = {
                onTrigger = function(player, npc)
                    return quest:event(43):oncePerZone() -- start
                end,
            },

            onEventFinish = {
                [43] = function(player, csid, option, npc)
                    if option == 1 and (player:hasItem(xi.items.SAPARA_OF_TRIALS) or npcUtil.giveItem(player, xi.items.SAPARA_OF_TRIALS)) then
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

        [xi.zone.CHATEAU_DORAGUILLE] = {
            ['Curilla'] = {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(48) -- complete
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        return quest:event(47) -- cont 2
                    else
                        return quest:event(46, player:hasItem(xi.items.SAPARA_OF_TRIALS) and 1 or 0) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SAPARA_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(45) -- unfinished weapon
                        else
                            return quest:progressEvent(44) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish = {
                [46] = function(player, csid, option, npc)
                    if option == 1 and not player:hasItem(xi.items.SAPARA_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.items.SAPARA_OF_TRIALS)
                    elseif option == 2 then
                        player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.OLD_WOUNDS)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [44] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [48] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                    player:addLearnedWeaponskill(xi.ws_unlock.SAVAGE_BLADE)
                    player:messageSpecial(chateauID.text.SAVAGE_BLADE_LEARNED)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.QUICKSAND_CAVES] = {
            ['qm3'] = {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        player:addKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        return quest:messageSpecial(quicksandCavesID.text.KEYITEM_OBTAINED, xi.ki.ANNALS_OF_TRUTH)
                    elseif
                        player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and
                        not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and
                        npcUtil.popFromQM(player, npc, quicksandCavesID.mob.GIRTABLULU, {hide = 0})
                    then
                        return quest:messageSpecial(quicksandCavesID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Girtablulu'] = {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    player:setLocalVar('killed_wsnm', 1)
                end,
            },
        },
    },
}

return quest
