-----------------------------------
-- Blood and Glory
-- Shantotto !pos 122 -2 112 239
-- qm3 !pos 119 20 144 205
-----------------------------------
local windurstWallsID  = zones[xi.zone.WINDURST_WALLS]
local ifritsCauldronID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.BLOOD_AND_GLORY)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.WINDURST,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:canEquipItem(xi.item.POLE_OF_TRIALS, true) and
                player:getCharSkillLevel(xi.skill.STAFF) / 10 >= 230 and
                not player:hasKeyItem(xi.keyItem.WEAPON_TRAINING_GUIDE)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(445):oncePerZone() -- start
                end,
            },

            onEventFinish =
            {
                [445] = function(player, csid, option, npc)
                    if
                        player:hasItem(xi.item.POLE_OF_TRIALS) or
                        npcUtil.giveItem(player, xi.item.POLE_OF_TRIALS)
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

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ANNALS_OF_TRUTH) then
                        return quest:progressEvent(450) -- complete
                    elseif player:hasKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH) then
                        return quest:event(449) -- cont 2
                    else
                        return quest:event(446, 0, xi.item.POLE_OF_TRIALS, 0, 0, player:hasItem(xi.item.POLE_OF_TRIALS) and 2 or 0) -- cont 1
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.POLE_OF_TRIALS) then
                        local wsPoints = trade:getItem(0):getWeaponskillPoints()

                        if wsPoints < 300 then
                            return quest:event(447) -- unfinished weapon
                        else
                            return quest:progressEvent(448, 0, 0, xi.ki.ANNALS_OF_TRUTH) -- finished weapon
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [446] = function(player, csid, option, npc)
                    if option == 1 and not player:hasItem(xi.item.POLE_OF_TRIALS) then
                        npcUtil.giveItem(player, xi.item.POLE_OF_TRIALS)
                    elseif option == 3 then
                        player:delQuest(xi.questLog.WINDURST, xi.quest.id.windurst.BLOOD_AND_GLORY)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                    end
                end,

                [448] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                end,

                [450] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.MAP_TO_THE_ANNALS_OF_TRUTH)
                        player:delKeyItem(xi.ki.ANNALS_OF_TRUTH)
                        player:delKeyItem(xi.ki.WEAPON_TRAINING_GUIDE)
                        player:addLearnedWeaponskill(xi.wsUnlock.RETRIBUTION)
                        player:messageSpecial(windurstWallsID.text.RETRIBUTION_LEARNED)
                        player:setPos(121, -3, 111)
                    end
                end,
            },
        },

        [xi.zone.IFRITS_CAULDRON] =
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
                        npcUtil.popFromQM(player, npc, ifritsCauldronID.mob.CAILLEACH_BHEUR, { hide = 0 })
                    then
                        return quest:messageSpecial(ifritsCauldronID.text.SENSE_OMINOUS_PRESENCE)
                    end
                end,
            },

            ['Cailleach_Bheur'] =
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
