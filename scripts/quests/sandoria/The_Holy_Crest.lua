-----------------------------------
-- The Holy Crest
-- !addquest 0 93
-----------------------------------
-- Ceraulian !pos 1.8 -8 -120 232
-- Arminibit !pos 1.8 -8 -120 232
-- Novalmauge !pos 34 -24 20 167
-- Morjean !pos 96 0 116 231
-- Excavation Point #1 !gotoid 17588776
-- QM1 MERIPHATAUD_MOUNTAINS !pos 639 -15 6.2 119
-- Rahal: !pos -27 0 -8 233
-- Hut Door: !gotoid 17350950
-----------------------------------
local northernSandoriaID  = zones[xi.zone.NORTHERN_SAN_DORIA]
local ghelsbaID           = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------
local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST)

quest.reward =
{
    fame     = 60,
    fameArea = xi.fameArea.SANDORIA,
    title    = xi.title.HEIR_TO_THE_HOLY_CREST,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Arminibit'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL then -- capture shows have to be 30 + to get correct dialog even after talking to them once.
                        return quest:progressEvent(24)
                    end
                end,
            },

            ['Ceraulian'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL then -- capture shows have to be 30 + to get correct dialog even after talking to them once.
                        return quest:progressEvent(24)
                    end
                end,
            },

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
        {
            ['Novalmauge'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(6)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(7)
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Morjean'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(65)
                    end
                end,
            },

            onEventFinish =
            {
                [65] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            ['Excavation_Point'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') >= 3 and -- allows players who drop it to get another one...
                        not player:hasItem(xi.item.WYVERN_EGG)
                    then
                        if npcUtil.tradeHasExactly(trade, xi.item.PICKAXE) then
                            local chance = math.random(1, 5)
                            if chance <= 2 then
                                npcUtil.giveItem(player, xi.item.WYVERN_EGG)
                                player:tradeComplete(false)
                                player:startEvent(60, 1159, 0, 0, xi.item.WYVERN_EGG)-- successful no break
                                return quest:noAction()
                            elseif chance == 3 then
                                npcUtil.giveItem(player, xi.item.WYVERN_EGG)
                                player:confirmTrade()
                                player:startEvent(60, 1159, 1, 0, xi.item.WYVERN_EGG) -- successful but breaks
                                return quest:noAction()
                            elseif chance == 4 then
                                player:confirmTrade()
                                player:startEvent(60, 0, 1, 0) -- unsuccessful and breaks
                                return quest:noAction()
                            elseif chance == 5 then
                                player:tradeComplete(false)
                                player:startEvent(60, 0, 0, 0) -- unsuccessful and no break
                                return quest:noAction()
                            end
                        end
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Morjean'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        not player:hasItem(xi.item.WYVERN_EGG)
                    then
                        return quest:messageSpecial(northernSandoriaID.text.LAID_DEEP)
                    elseif
                        quest:getVar(player, 'Prog') == 3 and
                        player:hasItem(xi.item.WYVERN_EGG)
                    then
                        return quest:progressEvent(62)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:messageSpecial(northernSandoriaID.text.NEVER_HEARD_DOC)
                    end
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },

        [xi.zone.MERIPHATAUD_MOUNTAINS] =
        {
            ['qm1'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.WYVERN_EGG) and
                        quest:getVar(player, 'Prog') == 4
                    then
                        return quest:progressEvent(33)
                    end
                end,
            },

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Rahal'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 5 and
                        not player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
                    then
                        return quest:progressEvent(60)
                    elseif
                        quest:getVar(player, 'Prog') == 5 and
                        player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
                    then
                        return quest:event(122)
                    end
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DRAGON_CURSE_REMEDY)
                end,
            },
        },

        [xi.zone.GHELSBA_OUTPOST] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == xi.battlefield.id.HOLY_CREST and
                        player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
                    then
                        player:delKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
                        player:unlockJob(xi.job.DRG)
                        player:messageSpecial(ghelsbaID.text.YOU_CAN_NOW_BECOME_A_DRAGOON)
                        player:setPetName(xi.pet.type.WYVERN, option + 1)
                        quest:complete(player)
                    end
                end,
            },
        },
    },
}

return quest
