-----------------------------------
-- The Weight of Your Limits
-- Iron Eater !pos 92 -19.6 2 237
-- qm1 !pos -324 1 474 121
-----------------------------------
local metalworksID = zones[xi.zone.METALWORKS]
local ziTahID      = zones[xi.zone.THE_SANCTUARY_OF_ZITAH]
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.THE_WEIGHT_OF_YOUR_LIMITS)

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
                player:canEquipItem(xi.item.AXE_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.GREAT_AXE) / 10 >= 240 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.METALWORKS] =
        {
            ['Iron_Eater'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(790):oncePerZone() -- start
                end,
            },

            onEventFinish =
            {
                [790] = function(player, csid, option, npc)
                    if
                        player:hasItem(xi.item.AXE_OF_TRIALS) or
                        npcUtil.giveItem(player, xi.item.AXE_OF_TRIALS)
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
            ['Iron_Eater'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(794) -- complete
                    else
                        local hideReacquireMenuItem = (player:hasItem(xi.item.AXE_OF_TRIALS) or player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)) and 1 or 0
                        return quest:event(791, hideReacquireMenuItem) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.AXE_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(792) -- unfinished weapon
                        else
                            return quest:progressEvent(793) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [791] = function(player, csid, option, npc)
                    if option == 1 and not player:hasItem(xi.item.AXE_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.item.AXE_OF_TRIALS)
                    elseif option == 2 then
                        player:delQuest(xi.questLog.BASTOK, xi.quest.id.bastok.THE_WEIGHT_OF_YOUR_LIMITS)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [793] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [794] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                        player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:addLearnedWeaponskill(xi.wsUnlock.STEEL_CYCLONE)
                        player:messageSpecial(metalworksID.text.STEEL_CYCLONE_LEARNED)
                    end
                end,
            },
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
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
                        npcUtil.popFromQM(player, npc, ziTahID.mob.GREENMAN, { hide = 0 })
                    then
                        return quest:messageSpecial(ziTahID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Greenman'] =
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
