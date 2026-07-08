-----------------------------------
-- Bugi Soden
-- Ryoma !pos -23 0 -9 252
-- qm1 !pos 110 15 162 213
-----------------------------------
local norgID   = zones[xi.zone.NORG]
local onzozoID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.BUGI_SODEN)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.NORG,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:canEquipItem(xi.item.KODACHI_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.KATANA) / 10 >= 250 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.NORG] =
        {
            ['Ryoma'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(184):oncePerZone() -- start
                end,
            },

            onEventFinish =
            {
                [184] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        (player:hasItem(xi.item.KODACHI_OF_TRIALS) or npcUtil.giveItem(player, xi.item.KODACHI_OF_TRIALS))
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

        [xi.zone.NORG] =
        {
            ['Ryoma'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(189) -- complete
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        return quest:event(188) -- cont 2
                    else
                        return quest:event(185) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.KODACHI_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(186) -- unfinished weapon
                        else
                            return quest:progressEvent(187) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [185] = function(player, csid, option, npc)
                    if option == 2 then
                        player:delQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.BUGI_SODEN)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    elseif not player:hasItem(xi.item.KODACHI_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.item.KODACHI_OF_TRIALS)
                    end
                end,

                [187] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [189] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                        player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:addLearnedWeaponskill(xi.wsUnlock.BLADE_KU)
                        player:messageSpecial(norgID.text.BLADE_KU_LEARNED)
                    end
                end,
            },
        },

        [xi.zone.LABYRINTH_OF_ONZOZO] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if player:getLocalVar('killed_wsnm') == 1 then
                        player:setLocalVar('killed_wsnm', 0)
                        return quest:keyItem(xi.ki.ANNALS_OF_TRUTH)
                    elseif
                        player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) and
                        not player:hasKeyItem(xi.keyItem.ANNALS_OF_TRUTH) and
                        npcUtil.popFromQM(player, npc, onzozoID.mob.MEGAPOD_MEGALOPS, { hide = 0 })
                    then
                        return quest:messageSpecial(onzozoID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Megapod_Megalops'] =
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
