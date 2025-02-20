-----------------------------------
-- Old Wounds
-- Curilla !pos 27 0.1 0.1 233
-- qm3 !pos -145 2 446 208
-----------------------------------
local chateauID = zones[xi.zone.CHATEAU_DORAGUILLE]
local quicksandCavesID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.OLD_WOUNDS)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.SANDORIA,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:canEquipItem(xi.item.SAPARA_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.SWORD) / 10 >= 240 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(43):oncePerZone() -- start
                end,
            },

            onEventFinish =
            {
                [43] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        (
                            player:hasItem(xi.item.SAPARA_OF_TRIALS) or
                            npcUtil.giveItem(player, xi.item.SAPARA_OF_TRIALS)
                        )
                    then
                        npcUtil.giveKeyItem(player, xi.keyItem.WEAPON_TRAINING_GUIDE)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(48) -- complete
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        return quest:event(47) -- cont 2
                    else
                        return quest:event(46, player:hasItem(xi.item.SAPARA_OF_TRIALS) and 1 or 0) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.SAPARA_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(45) -- unfinished weapon
                        else
                            return quest:progressEvent(44) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [46] = function(player, csid, option, npc)
                    if option == 1 and not player:hasItem(xi.item.SAPARA_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.item.SAPARA_OF_TRIALS)
                    elseif option == 2 then
                        player:delQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.OLD_WOUNDS)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [44] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [48] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                        player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:addLearnedWeaponskill(xi.wsUnlock.SAVAGE_BLADE)
                        player:messageSpecial(chateauID.text.SAVAGE_BLADE_LEARNED)
                    end
                end,
            },
        },

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        return quest:keyItem(xi.ki.ANNALS_OF_TRUTH)
                    elseif
                        player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and
                        not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and
                        npcUtil.popFromQM(player, npc, quicksandCavesID.mob.GIRTABLULU, { hide = 0 })
                    then
                        return quest:messageSpecial(quicksandCavesID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Girtablulu'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        player:setLocalVar('killed_wsnm', 1)
                    end
                end,
            },
        },
    },
}

return quest
