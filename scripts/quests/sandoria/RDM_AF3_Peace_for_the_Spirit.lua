-----------------------------------
-- Peace for the Spirit
-----------------------------------
-- Log ID: 0, Quest ID: 86
-- Curilla !pos 27 0.1 0.1 233
-- Sharzalion !pos 95 0 111 230
-- Daggo !pos 89 1 119 230
-- Miser Murphy !pos -14 -16 70 204
-- Dry Fountain !pos -14 -16 70 204
-- Oaken Box !pos -164 0 224 200
-----------------------------------
local feiyinID = zones[xi.zone.FEIYIN]
local gcID     = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT)

quest.reward =
{
    item     = xi.item.WARLOCKS_CHAPEAU,
    fame     = 60,
    fameArea = xi.fameArea.SANDORIA,
    title    = xi.title.PARAGON_OF_RED_MAGE_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS) and
                player:getMainJob() == xi.job.RDM and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] = quest:progressEvent(109),

            onEventFinish =
            {
                [109] = function(player, csid, option, npc)
                    if option == 1 then
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
                    local progress = quest:getVar(player, 'Prog')

                    if progress >= 1 then
                        return quest:event(113)
                    else
                        return quest:event(108)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sharzalion'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:progressEvent(64)
                    elseif progress == 1 then
                        return quest:event(65)
                    elseif progress == 2 then
                        return quest:progressEvent(66)
                    elseif progress == 5 then
                        return quest:event(68)
                    end
                end,
            },

            ['Daggao'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 3 then
                        return quest:progressEvent(72)
                    elseif progress == 5 then
                        return quest:event(73)
                    end
                end,
            },

            onEventFinish =
            {
                [64] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [66] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [72] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.FEIYIN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        not player:hasItem(xi.item.ANTIQUE_COIN)
                    then
                        SpawnMob(feiyinID.mob.MISER_MURPHY)
                    end
                end,
            },

            ['Dry_Fountain'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.ANTIQUE_COIN) then
                        return quest:progressEvent(17)
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.GARLAIGE_CITADEL] =
        {
            ['Oaken_Box'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        if
                            quest:getLocalVar(player, 'nmPopped') == 0 and -- players can kill NM, get nail puller zone and repop until they trade to box!
                            npcUtil.popFromQM(player, npc, gcID.mob.GUARDIAN_STATUE, { claim = true, hide = 0 })
                        then
                            quest:setLocalVar(player, 'nmPopped', 1) -- players can only pop once/zone
                            return quest:noAction()
                        elseif GetMobByID(gcID.mob.GUARDIAN_STATUE):isAlive() then
                            return quest:messageSpecial(gcID.text.SOMETHING_WRONG)
                        elseif
                            quest:getLocalVar(player, 'nmPopped') == 1 and
                            not GetMobByID(gcID.mob.GUARDIAN_STATUE):isAlive()
                        then
                            return quest:messageSpecial(gcID.text.BOX_SCATTERED, xi.item.NAIL_PULLER)
                        end
                    elseif quest:getVar(player, 'Prog') == 5 then
                        return quest:messageSpecial(gcID.text.BOX_DEFAULT)
                    end
                end,

                onTrade = function(player, npc, trade)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        npcUtil.tradeHasExactly(trade, xi.item.NAIL_PULLER) and
                        progress == 4
                    then
                        return quest:progressEvent(14)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 5 then
                        return 49
                    end
                end,
            },

            onEventFinish =
            {
                [49] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] = quest:event(52):replaceDefault(),
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sharzalion'] = quest:event(69):replaceDefault(),
            ['Daggao'] = quest:event(60):replaceDefault(),
        },
    },
}

return quest
