-----------------------------------
-- Shoot First, Ask Questions Later
-- Cid !pos -12 -12 1 237
-- qm1 !pos -11 -19 -177 153
-----------------------------------
local metalworksID = zones[xi.zone.METALWORKS]
local boyahdaTreeID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.SHOOT_FIRST_ASK_QUESTIONS_LATER)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.BASTOK,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:canEquipItem(xi.item.GUN_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.MARKSMANSHIP) / 10 >= 250 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(795):oncePerZone() -- start
                end,
            },

            onEventFinish =
            {
                [795] = function(player, csid, option, npc)
                    if
                        player:hasItem(xi.item.GUN_OF_TRIALS) or
                        npcUtil.giveItem(player, xi.item.GUN_OF_TRIALS)
                    then
                        npcUtil.giveKeyItem(player, xi.keyItem.WEAPON_TRAINING_GUIDE)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(799) -- complete
                    else
                        local hideReacquireMenuItem = (player:hasItem(xi.item.GUN_OF_TRIALS) or player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)) and 1 or 0
                        return quest:event(796, hideReacquireMenuItem) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.GUN_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(797) -- unfinished weapon
                        else
                            return quest:progressEvent(798) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [796] = function(player, csid, option, npc)
                    if
                        option == 1 and
                        not player:hasItem(xi.item.GUN_OF_TRIALS)
                    then
                        npcUtil.giveItem(player, xi.item.GUN_OF_TRIALS)
                    elseif option == 2 then
                        player:delQuest(xi.questLog.BASTOK, xi.quest.id.bastok.SHOOT_FIRST_ASK_QUESTIONS_LATER)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [798] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [799] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                        player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:addLearnedWeaponskill(xi.wsUnlock.DETONATOR)
                        player:messageSpecial(metalworksID.text.DETONATOR_LEARNED)
                    end
                end,
            },
        },

        [xi.zone.THE_BOYAHDA_TREE] =
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
                        npcUtil.popFromQM(player, npc, boyahdaTreeID.mob.BEET_LEAFHOPPER, { hide = 0 })
                    then
                        return quest:messageSpecial(boyahdaTreeID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Beet_Leafhopper'] =
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
