-----------------------------------
-- A Question of Taste
-- Log ID: 5, Quest ID: 3
-- Etteh_Sulaej        !pos 98.153 -15.000 -113.251
-- Angelica            !pos -64 -9.25 -9
-- Stone Picture Frame !pos 79.876 0.500 -36.964
-----------------------------------
local templeID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.A_QUESTION_OF_TASTE)

quest.reward =
{
    gil = 3000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 6
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] = quest:progressCutscene(44),

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_ANGELICA)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 1 then
                        return quest:progressEvent(47)
                    elseif progress == 4 then
                        return quest:progressEvent(50)
                    elseif progress >= 2 then
                        return quest:event(49)
                    else
                        return quest:event(45)
                    end
                end,
            },

            ['Jakoh_Wahcondalo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 2 then
                        return quest:event(48)
                    else
                        return quest:event(46)
                    end
                end,
            },

            onEventFinish =
            {
                [47] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:delKeyItem(xi.ki.ANGELICAS_LETTER)
                end,

                [50] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.RIPPED_FINAL_FANTASY_PAINTING)
                        quest:setMustZone(player)
                    end
                end,
            },
        },

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['Stone_Picture_Frame_QoT'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')
                    local questNM  = GetMobByID(templeID.mob.TROMPE_LOEIL)

                    if progress == 2 then
                        if quest:getVar(player, 'Wait') > GetSystemTime() then
                            player:messageSpecial(templeID.text.FRAME_FOR_A_PAINTING + 1)
                            return quest:messageSpecial(templeID.text.STILL_HANGS_ON_THE_WALL, xi.ki.RIPPED_FINAL_FANTASY_PAINTING)
                        elseif not questNM then
                            return
                        elseif not questNM:isSpawned() then
                            return quest:progressEvent(50, xi.ki.FINAL_FANTASY)
                        end
                    elseif progress == 3 then
                        npcUtil.giveKeyItem(player, xi.ki.RIPPED_FINAL_FANTASY_PAINTING)
                        quest:setVar(player, 'Prog', 4)
                        return quest:noAction()
                    end
                end,
            },

            ['Trompe_LOeil'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 2 then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.FINAL_FANTASY)
                        SpawnMob(templeID.mob.TROMPE_LOEIL):updateClaim(player)
                        quest:setVar(player, 'Wait', GetSystemTime() + 900) -- Sets a 15min cooldown before the player can repop the NM.
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME) and
                        not xi.quest.getMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)
                    then
                        if progress == 0 then
                            return quest:progressEvent(771)
                        else
                            return quest:event(772)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [771] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    npcUtil.giveKeyItem(player, xi.ki.FINAL_FANTASY)
                    npcUtil.giveKeyItem(player, xi.ki.ANGELICAS_LETTER)
                    player:delKeyItem(xi.ki.LETTER_TO_ANGELICA)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if quest:getMustZone(player) then
                        return quest:event(51)
                    elseif
                        -- The player cannot do the repeat if they meet the requirements for "Everyone's Grudging"
                        player:getCharVar('rancorCurse') == 1 and
                        player:getFameLevel(xi.fameArea.WINDURST) >= 7 and
                        not player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.EVERYONES_GRUDGING)
                    then
                        return -- Sends to default action as seen in captures
                    else
                        if progress == 3 then
                            return quest:progressEvent(57)
                        elseif progress >= 1 then
                            return quest:event(55)
                        else
                            if quest:getVar(player, 'Option') == 0 then
                                return quest:progressEvent(53)
                            else
                                return quest:progressEvent(54)
                            end
                        end
                    end
                end,
            },

            ['Jakoh_Wahcondalo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(52)
                    elseif quest:getVar(player, 'Prog') >= 1 then
                        return quest:event(56)
                    end
                end,
            },

            onEventFinish =
            {
                [53] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Option', 1)
                    else
                        quest:setVar(player, 'Prog', 1)
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.FINAL_FANTASY_PART_II)
                    end
                end,

                [54] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 1)
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.FINAL_FANTASY_PART_II)
                    end
                end,

                [57] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.RIPPED_FINAL_FANTASY_PAINTING)
                        quest:setMustZone(player)
                    end
                end,
            },
        },

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['Stone_Picture_Frame_QoT'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')
                    local questNM  = GetMobByID(templeID.mob.TROMPE_LOEIL)

                    if progress == 1 then
                        if quest:getVar(player, 'Wait') > GetSystemTime() then
                            player:messageSpecial(templeID.text.FRAME_FOR_A_PAINTING + 1)
                            return quest:messageSpecial(templeID.text.STILL_HANGS_ON_THE_WALL, xi.ki.RIPPED_FINAL_FANTASY_PAINTING)
                        elseif not questNM then
                            return
                        elseif not questNM:isSpawned() then
                            return quest:progressEvent(51, xi.ki.FINAL_FANTASY_PART_II)
                        end
                    elseif progress == 2 then
                        npcUtil.giveKeyItem(player, xi.ki.RIPPED_FINAL_FANTASY_PAINTING)
                        quest:setVar(player, 'Prog', 3)
                        return quest:noAction()
                    end
                end,
            },

            ['Trompe_LOeil'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.FINAL_FANTASY_PART_II)
                        SpawnMob(templeID.mob.TROMPE_LOEIL):updateClaim(player)
                        quest:setVar(player, 'Wait', GetSystemTime() + 900) -- Sets a 15min cooldown before the player can repop the NM.
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(772)
                    else
                        return quest:event(773):replaceDefault()
                    end
                end,
            },
        },
    },
}

return quest
