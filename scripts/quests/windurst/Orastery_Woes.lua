-----------------------------------
-- Orastery Woes
-- Kuroido-Moido !pos -112.5 -4.2 102.9 240
-- qm1 !pos 197 -8 -27.5 122
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require('scripts/globals/interaction/quest')
require("scripts/globals/weaponskillids")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ORASTERY_WOES)

quest.reward = {
    fame = 30,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:canEquipItem(xi.items.CLUB_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.CLUB) / 10 >= 230 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.PORT_WINDURST] = {
            ['Kuroido-Moido'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(578) -- start
                end,
            },

            onEventFinish = {
                [578] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.CLUB_OF_TRIALS) then
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

        [xi.zone.PORT_WINDURST] = {
            ['Kuroido-Moido'] = {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(583) -- complete
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        return quest:event(582) -- cont 2
                    else
                        return quest:event(579) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    local wsPoints = (trade:getItem(0):getWeaponskillPoints())
                    if npcUtil.tradeHasExactly(trade, xi.items.CLUB_OF_TRIALS) then
                        if wsPoints < 300 then
                            return quest:event(580) -- unfinished weapon
                        else
                            return quest:progressEvent(581) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish = {
                [579] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveItem(player, xi.items.CLUB_OF_TRIALS)
                    elseif option == 3 then
                        player:delQuest(WINDURST, ORASTERY_WOES)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,
                [581] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,
                [583] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                    player:addLearnedWeaponskill(xi.ws_unlock.BLACK_HALO)
                    player:messageSpecial(zones[player:getZoneID()].text.BLACK_HALO_LEARNED)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.ROMAEVE] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        player:addKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        return quest:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, xi.ki.ANNALS_OF_TRUTH)
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and npcUtil.popFromQM(player, npc, zones[player:getZoneID()].mob.ELDHRIMNIR, {hide = 0}) then
                        return quest:messageSpecial(zones[player:getZoneID()].text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },
            ['Eldhrimnir'] = {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    player:setLocalVar('killed_wsnm', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status >= QUEST_AVAILABLE
        end,

        [xi.zone.ROMAEVE] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                end,
            },
        },
    },
}


return quest
