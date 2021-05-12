-----------------------------------
-- Axe the Competition
-- Brutus !pos -55 8 95 244
-- qm9 !pos 218 -8 206 159
-----------------------------------
require("scripts/globals/interaction/quest")
require("scripts/globals/weaponskillids")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------
local upperJeunoID = require("scripts/zones/Upper_Jeuno/IDs")
local uggalepihID = require("scripts/zones/Temple_of_Uggalepih/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.AXE_THE_COMPETITION)

quest.reward = {
    fame = 30,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:canEquipItem(xi.items.PICK_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.AXE) / 10 >= 240 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.UPPER_JEUNO] = {
            ['Brutus'] = {
                onTrigger = function(player, npc)
                    return quest:event(12):oncePerZone() -- start
                end,
            },

            onEventFinish = {
                [12] = function(player, csid, option, npc)
                    if option == 1 and (player:hasItem(xi.items.PICK_OF_TRIALS) or npcUtil.giveItem(player, xi.items.PICK_OF_TRIALS)) then
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

        [xi.zone.UPPER_JEUNO] = {
            ['Brutus'] = {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(17) -- complete
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        return quest:event(16) -- cont 2
                    else
                        return quest:event(15, player:hasItem(xi.items.PICK_OF_TRIALS) and 1 or 0) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.PICK_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(14) -- unfinished weapon
                        else
                            return quest:progressEvent(13) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish = {
                [15] = function(player, csid, option, npc)
                    if option == 1 and not player:hasItem(xi.items.PICK_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.items.PICK_OF_TRIALS)
                    elseif option == 2 then
                        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.AXE_THE_COMPETITION)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [13] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [17] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                    player:addLearnedWeaponskill(xi.ws_unlock.DECIMATION)
                    player:messageSpecial(upperJeunoID.text.DECIMATION_LEARNED)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.TEMPLE_OF_UGGALEPIH] = {
            ['qm9'] = {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        player:addKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        return quest:messageSpecial(uggalepihID.text.KEYITEM_OBTAINED, xi.ki.ANNALS_OF_TRUTH)
                    elseif
                        player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and
                        not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and
                        npcUtil.popFromQM(player, npc, uggalepihID.mob.YALLERY_BROWN, {hide = 0})
                    then
                        return quest:messageSpecial(uggalepihID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Yallery_Brown'] = {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    player:setLocalVar('killed_wsnm', 1)
                end,
            },
        },
    },
}

return quest
