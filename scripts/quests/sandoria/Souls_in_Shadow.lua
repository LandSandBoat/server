-----------------------------------
-- Souls in Shadow
-- Novalmauge !pos 70 -24 21 167
-- qm2 !pos 118 36 -281 160
-----------------------------------
require("scripts/globals/interaction/quest")
require("scripts/globals/weaponskillids")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------
local bostaunieuxID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
local denOfRancorID = require("scripts/zones/Den_of_Rancor/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SOULS_IN_SHADOW)

quest.reward = {
    fame = 30,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:canEquipItem(xi.items.SCYTHE_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.SCYTHE) / 10 >= 240 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] = {
            ['Novalmauge'] = {
                onTrigger = function(player, npc)
                    return quest:event(0):oncePerZone() -- start
                end,
            },

            onEventFinish = {
                [0] = function(player, csid, option, npc)
                    if option == 1 and (player:hasItem(xi.items.SCYTHE_OF_TRIALS) or npcUtil.giveItem(player, xi.items.SCYTHE_OF_TRIALS)) then
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

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] = {
            ['Novalmauge'] = {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(5) -- complete
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        return quest:event(4) -- cont 2
                    else
                        return quest:event(3, player:hasItem(xi.items.SCYTHE_OF_TRIALS) and 1 or 0) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SCYTHE_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(2) -- unfinished weapon
                        else
                            return quest:progressEvent(1) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish = {
                [3] = function(player, csid, option, npc)
                    if option == 1 and not player:hasItem(xi.items.SCYTHE_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.items.SCYTHE_OF_TRIALS)
                    elseif option == 2 then
                        player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SOULS_IN_SHADOW)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [1] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [5] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                    player:addLearnedWeaponskill(xi.ws_unlock.SPIRAL_HELL)
                    player:messageSpecial(bostaunieuxID.text.SPIRAL_HELL_LEARNED)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.DEN_OF_RANCOR] = {
            ['qm2'] = {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        player:addKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        return quest:messageSpecial(denOfRancorID.text.KEYITEM_OBTAINED, xi.ki.ANNALS_OF_TRUTH)
                    elseif
                        player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and
                        not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and
                        npcUtil.popFromQM(player, npc, denOfRancorID.mob.MOKUMOKUREN, {hide = 0})
                    then
                        return quest:messageSpecial(denOfRancorID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Mokumokuren'] = {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    player:setLocalVar('killed_wsnm', 1)
                end,
            },
        },
    },
}

return quest
