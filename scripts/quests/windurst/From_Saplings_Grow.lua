-----------------------------------
-- From Saplings Grow
-- Perih Vashai !pos 117 -3 92 241
-- qm1 !pos -157 -8 198.2 113
-----------------------------------
require("scripts/globals/interaction/quest")
require("scripts/globals/weaponskillids")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------
local windurstWoodsID = require("scripts/zones/Windurst_Woods/IDs")
local capeTerigganID = require("scripts/zones/Cape_Teriggan/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FROM_SAPLINGS_GROW)

quest.reward = {
    fame = 30,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:canEquipItem(xi.items.BOW_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.ARCHERY) / 10 >= 250 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.WINDURST_WOODS] = {
            ['Perih_Vashai'] = {
                onTrigger = function(player, npc)
                    return quest:event(661):oncePerZone() -- start
                end,
            },

            onEventFinish = {
                [661] = function(player, csid, option, npc)
                    if player:hasItem(xi.items.BOW_OF_TRIALS) or npcUtil.giveItem(player, xi.items.BOW_OF_TRIALS) then
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

        [xi.zone.WINDURST_WOODS] = {
            ['Perih_Vashai'] = {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(666) -- complete
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        return quest:event(665) -- cont 2
                    else
                        return quest:event(662, 0, xi.items.BOW_OF_TRIALS, 0, 0, player:hasItem(xi.items.BOW_OF_TRIALS) and 2 or 0) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.BOW_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(663) -- unfinished weapon
                        else
                            return quest:progressEvent(664, 0, 0, xi.ki.ANNALS_OF_TRUTH) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish = {
                [662] = function(player, csid, option, npc)
                    if option == 1 and not player:hasItem(xi.items.BOW_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.items.BOW_OF_TRIALS)
                    elseif option == 3 then
                        player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FROM_SAPLINGS_GROW)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [664] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [666] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                    player:addLearnedWeaponskill(xi.ws_unlock.EMPYREAL_ARROW)
                    player:messageSpecial(windurstWoodsID.text.EMPYREAL_ARROW_LEARNED)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.CAPE_TERIGGAN] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        player:addKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        return quest:messageSpecial(capeTerigganID.text.KEYITEM_OBTAINED, xi.ki.ANNALS_OF_TRUTH)
                    elseif
                        player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and
                        not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and
                        npcUtil.popFromQM(player, npc, capeTerigganID.mob.STOLAS, {hide = 0})
                    then
                        return quest:messageSpecial(capeTerigganID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Stolas'] = {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    player:setLocalVar('killed_wsnm', 1)
                end,
            },
        },
    },
}

return quest
