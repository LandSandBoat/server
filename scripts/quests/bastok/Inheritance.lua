-----------------------------------
-- Inheritance
-- Gumbah !pos 52 0 -36 234
-- qm1 !pos -660 0 -338 125
-----------------------------------
require("scripts/globals/interaction/quest")
require("scripts/globals/weaponskillids")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------
local bastokMinesID = require("scripts/zones/Bastok_Mines/IDs")
local westernAltepaID = require("scripts/zones/Western_Altepa_Desert/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.INHERITANCE)

quest.reward = {
    fame = 30,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:canEquipItem(xi.items.SWORD_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.GREAT_SWORD) / 10 >= 250 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.BASTOK_MINES] = {
            ['Gumbah'] = {
                onTrigger = function(player, npc)
                    return quest:event(190):oncePerZone() -- start
                end,
            },

            onEventFinish = {
                [190] = function(player, csid, option, npc)
                    if player:hasItem(xi.items.SWORD_OF_TRIALS) or npcUtil.giveItem(player, xi.items.SWORD_OF_TRIALS) then
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

        [xi.zone.BASTOK_MINES] = {
            ['Gumbah'] = {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(194) -- complete
                    else
                        local hideReacquireMenuItem = (player:hasItem(xi.items.SWORD_OF_TRIALS) or player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)) and 1 or 0
                        return quest:event(191, showReacquireMenuItem) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SWORD_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(192) -- unfinished weapon
                        else
                            return quest:progressEvent(193) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish = {
                [191] = function(player, csid, option, npc)
                    if option == 1 and not player:hasItem(xi.items.SWORD_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.items.SWORD_OF_TRIALS)
                    elseif option == 2 then
                        player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.INHERITANCE)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [193] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [194] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                    player:addLearnedWeaponskill(xi.ws_unlock.GROUND_STRIKE)
                    player:messageSpecial(bastokMinesID.text.GROUND_STRIKE_LEARNED)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.WESTERN_ALTEPA_DESERT] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        player:addKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        return quest:messageSpecial(westernAltepaID.text.KEYITEM_OBTAINED, xi.ki.ANNALS_OF_TRUTH)
                    elseif
                        player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and
                        not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and
                        npcUtil.popFromQM(player, npc, westernAltepaID.mob.MAHARAJA, {hide = 0})
                    then
                        return quest:messageSpecial(westernAltepaID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Maharaja'] = {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    player:setLocalVar('killed_wsnm', 1)
                end,
            },
        },
    },
}

return quest
