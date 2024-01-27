-----------------------------------
-- The Talekeeper's Truth
-----------------------------------
-- Log ID: 1, Quest ID: 55
-- Phara         : !pos 75 0 -80 234
-- Deidogg       : !pos -13 7 29 234
-- qm_talekeeper : !pos 15 -31 -94 143
-----------------------------------
local palboroughMinesID = zones[xi.zone.PALBOROUGH_MINES]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPERS_TRUTH)

quest.reward =
{
    fame     = 40,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.FIGHTERS_CALLIGAE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN) and
                player:getMainJob() == xi.job.WAR and
                player:getMainLvl() >= 50
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Deidogg'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(160)
                    elseif questProgress == 2 then
                        return quest:progressEvent(161)
                    end
                end,
            },

            ['Phara'] = quest:progressEvent(154),

            onEventFinish =
            {
                [154] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [160] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [161] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 0)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Deidogg'] =
            {
                onTrade = function(player, npc, trade)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 0 and
                        npcUtil.tradeHasExactly(trade, xi.item.MOTTLED_QUADAV_EGG)
                    then
                        return quest:progressEvent(162)
                    elseif
                        questProgress == 1 and
                        npcUtil.tradeHasExactly(trade, xi.item.PARASITE_SKIN)
                    then
                        return quest:progressEvent(164)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:event(163)
                    elseif questProgress == 2 then
                        if quest:getVar(player, 'Timer') <= VanadielUniqueDay() then
                            return quest:progressEvent(165)
                        else
                            return quest:event(166)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [162] = function(player, csid, option, npc)
                    player:confirmTrade()

                    quest:setVar(player, 'Prog', 1)
                end,

                [164] = function(player, csid, option, npc)
                    player:confirmTrade()

                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,

                [165] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setVar(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPERS_GIFT, 'Timer', VanadielUniqueDay() + 1)
                        xi.quest.setMustZone(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPERS_GIFT)
                    end
                end,
            },
        },

        [xi.zone.PALBOROUGH_MINES] =
        {
            ['qm_talekeeper'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.popFromQM(player, npc, palboroughMinesID.mob.NI_GHU_NESTFENDER, { hide = 0 })
                    then
                        return quest:messageSpecial(palboroughMinesID.text.SENSE_OF_FOREBODING)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Deidogg'] = quest:event(166):replaceDefault(),
        },
    },
}

return quest
