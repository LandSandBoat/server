-----------------------------------
-- Methods Create Madness
-- Balasiel !pos -136 -11 64 230
-- qm1 !pos 107 0.7 -125.25 176
-----------------------------------
require('scripts/globals/interaction/quest')
require("scripts/globals/weaponskillids")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------
local southernSandOriaID = require("scripts/zones/Southern_San_dOria/IDs")
local seaSerpentGrottoID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.METHODS_CREATE_MADNESS)

quest.reward = {
    fame = 30,
}

quest.sections = {
    -- Talk to Balasiel in Southern San d'Oria who will give you the Spear of Trials and the Weapon Training Guide.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:canEquipItem(xi.items.SPEAR_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.POLEARM) / 10 >= 240 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Balasiel'] = {
                onTrigger = function(player, npc)
                    return quest:event(8):oncePerZone() -- start
                end,
            },

            onEventFinish = {
                [8] = function(player, csid, option, npc)
                    if option == 1 and (player:hasItem(xi.items.SPEAR_OF_TRIALS) or npcUtil.giveItem(player, xi.items.SPEAR_OF_TRIALS)) then
                        npcUtil.giveKeyItem(player, xi.keyItem.WEAPON_TRAINING_GUIDE)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Perform Weapon Skills with the Spear of Trials on monsters that grant XP until the latent effect disappears.
    -- Once you no longer receive the latent effect bonus, trade the Spear of Trials back to Balasiel, who will
    -- take the weapon from you and give you a Map to the Annals of Truth and tell you to head to Sea Serpent Grotto.
    -- Click the ??? to spawn the NM Water Leaper.
    -- Once the NM is dead, reexamine the ??? to obtain the Annals of Truth.
    -- Bring this back to Balasiel for your reward.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Balasiel'] = {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(13) -- complete
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        return quest:event(12) -- cont 2
                    else
                        return quest:event(11, player:hasItem(xi.items.SPEAR_OF_TRIALS) and 1 or 0) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SPEAR_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(10) -- unfinished weapon
                        else
                            return quest:progressEvent(9) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish = {
                [11] = function(player, csid, option, npc)
                    if option == 1 and not player:hasItem(xi.items.SPEAR_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.items.SPEAR_OF_TRIALS)
                    elseif option == 2 then
                        player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.METHODS_CREATE_MADNESS)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [9] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [13] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                    player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                    player:addLearnedWeaponskill(xi.ws_unlock.IMPULSE_DRIVE)
                    player:messageSpecial(southernSandOriaID.text.IMPULSE_DRIVE_LEARNED)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.SEA_SERPENT_GROTTO] = {
            ['qm1'] = {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        player:addKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        return quest:messageSpecial(seaSerpentGrottoID.text.KEYITEM_OBTAINED, xi.ki.ANNALS_OF_TRUTH)
                    elseif
                        player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and
                        not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and
                        npcUtil.popFromQM(player, npc, seaSerpentGrottoID.mob.WATER_LEAPER, {hide = 0})
                    then
                        return quest:messageSpecial(seaSerpentGrottoID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Water_Leaper'] = {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    player:setLocalVar('killed_wsnm', 1)
                end,
            },
        },
    },
}

return quest
