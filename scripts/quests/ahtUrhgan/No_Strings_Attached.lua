-----------------------------------
-- No Strings Attached
-----------------------------------
-- Log ID: 6, Quest ID: 7
-- Shamarhaan   : !pos -285.382 -13.021 -84.743 235
-- Iruki-Waraki : !pos 101.329 -6.999 -29.042 50
-- Ghatsad      : !pos 34.325 -7.804 57.511 50
-- qm10         : !pos 457.128 -8.249 60.795 54
-----------------------------------
local ahtUrhganID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
local arrapagoID  = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED)

quest.reward =
{
    item    = xi.item.ANIMATOR,
    keyItem = xi.ki.JOB_GESTURE_PUPPETMASTER,
    title   = xi.title.PROUD_AUTOMATON_OWNER,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Shamarhaan'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 0 then
                        return quest:progressEvent(434) -- This CS appears to be bugged on retail and no longer plays
                    else
                        return quest:event(435)
                    end
                end,
            },

            onEventFinish =
            {
                [434] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        return quest:progressEvent(260)
                    end
                end,
            },

            onEventFinish =
            {
                [260] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest Accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Shamarhaan'] = quest:event(435)
        },

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress <= 3 then
                        return quest:event(261)
                    elseif questProgress == 4 then
                        return quest:progressEvent(266)
                    end
                end,
            },

            ['Ghatsad'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(262)
                    elseif questProgress == 1 then
                        return quest:event(263):oncePerZone()
                    elseif
                        questProgress == 2 and
                        player:hasKeyItem(xi.ki.ANTIQUE_AUTOMATON)
                    then
                        return quest:progressEvent(264)
                    elseif
                        questProgress == 3 and
                        quest:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        return quest:progressEvent(265)
                    end
                end,
            },

            onEventFinish =
            {
                [262] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [264] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                    player:delKeyItem(xi.ki.ANTIQUE_AUTOMATON)
                end,

                [265] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [266] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:unlockJob(xi.job.PUP)
                        player:messageSpecial(ahtUrhganID.text.YOU_CAN_BECOME_PUP)
                        player:setPetName(xi.petType.AUTOMATON, option + 118)
                        player:unlockAttachment(xi.item.HARLEQUIN_FRAME)
                        player:unlockAttachment(xi.item.HARLEQUIN_HEAD)
                    end
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm10'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressCutscene(214)
                    else
                        return quest:messageSpecial(arrapagoID.text.PILE_OF_DISCARDED_MATERIALS)
                    end
                end,
            },

            onEventFinish =
            {
                [214] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ANTIQUE_AUTOMATON)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Section: Quest Completed
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:findItem(xi.item.ANIMATOR) and
                        npcUtil.tradeHas(trade, { { 'gil', 10000 } })
                    then
                        player:confirmTrade()
                        npcUtil.giveItem(player, xi.item.ANIMATOR)
                        return quest:messageName(ahtUrhganID.text.YOU_BETTER_NOT_LOSE_IT_AGAIN, 0, 0, 0, 0, true, false)
                    end
                end,

                onTrigger = function(player, npc)
                    if not player:findItem(xi.item.ANIMATOR) then
                        return quest:messageName(ahtUrhganID.text.YOU_LOST_YOUR_ANIMATOR, xi.item.ANIMATOR, 0, 0, 0, true, false)
                    else
                        return quest:event(267)
                    end
                end,
            },
        },
    },
}

return quest
