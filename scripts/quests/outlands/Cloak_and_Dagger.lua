-----------------------------------
-- Cloak and Dagger
-- Jakoh_Wahcondalo !pos 101 -16 -115 250
-- qm1 !pos 52.8 -1 19.9 212
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require('scripts/globals/interaction/quest')
require("scripts/globals/weaponskillids")
-----------------------------------

local quest = Quest:new(OUTLANDS, CLOAK_AND_DAGGER)

quest.reward = {
    fame = 30,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:canEquipItem(xi.items.DAGGER_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.DAGGER) / 10 >= 230 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.KAZHAM] = {
            ['Jakoh_Wahcondalo'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(279) -- start
                end,
            },

            onEventFinish = {
                [279] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.DAGGER_OF_TRIALS) then
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

        [xi.zone.KAZHAM] = {
            ['Jakoh_Wahcondalo'] = {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(284) -- complete
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        return quest:event(283) -- cont 2
                    else
                        return quest:event(280) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    local wsPoints = (trade:getItem(0):getWeaponskillPoints())
                    if npcUtil.tradeHasExactly(trade, xi.items.DAGGER_OF_TRIALS) then
                        if wsPoints < 300 then
                            return quest:event(281) -- unfinished weapon
                        else
                            return quest:progressEvent(282) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish = {
                [280] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveItem(player, xi.items.DAGGER_OF_TRIALS)
                    elseif option == 3 then
                        player:delQuest(OUTLANDS, CLOAK_AND_DAGGER)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,
                [282] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,
                [284] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                    player:addLearnedWeaponskill(xi.ws_unlock.EVISCERATION)
                    player:messageSpecial(zones[player:getZoneID()].text.EVISCERATION_LEARNED)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.GUSTAV_TUNNEL] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        player:addKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        return quest:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, xi.ki.ANNALS_OF_TRUTH)
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and npcUtil.popFromQM(player, npc, zones[player:getZoneID()].mob.BARONIAL_BAT, {hide = 0}) then
                        return quest:messageSpecial(zones[player:getZoneID()].text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },
            ['Baronial_Bat'] = {
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

        [xi.zone.GUSTAV_TUNNEL] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    return quest:messageSpecial(zones[player:getZoneID()].text.NOTHING_OUT_OF_ORDINARY)
                end,
            },
        },
    },
}


return quest
