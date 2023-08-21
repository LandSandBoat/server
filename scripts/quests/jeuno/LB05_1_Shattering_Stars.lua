-----------------------------------
-- Shattering Stars
-----------------------------------
-- Log ID: 3, Quest ID: 132
-- Maat : !pos 8 3 118 243
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)

quest.reward =
{
    fame = 80,
    fameArea = xi.quest.fame_area.JEUNO,
    title = xi.title.STAR_BREAKER,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() <= 15 and -- Only the "old" jobs may start this quest.
                player:getMainLvl() >= 66 and
                player:getLevelCap() == 70 and
                xi.settings.main.MAX_LEVEL >= 75
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(92, player:getMainJob())
                end,
            },

            onEventFinish =
            {
                [92] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
                player:getMainJob() <= 15 and
                player:getMainLvl() >= 66
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 1 then
                        return quest:progressEvent(93) -- Complete quest.
                    elseif quest:getVar(player, 'Prog') == 0 then
                        return quest:event(91, player:getMainJob())
                    end
                end,

                onTrade = function(player, npc, trade)
                    local properTestimony = xi.item.WARRIORS_TESTIMONY + player:getMainJob() - 1

                    if
                        npcUtil.tradeHasExactly(trade, properTestimony) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(64, player:getMainJob())
                    end
                end,
            },

            onEventFinish =
            {
                [64] = function(player, csid, option, npc)
                    if option == 1 then
                        local mJob = player:getMainJob()
                        if mJob == xi.job.MNK or mJob == xi.job.WHM or mJob == xi.job.SMN then
                            player:setPos(299.316, -123.591, 353.760, 66, 146)
                        elseif mJob == xi.job.WAR or mJob == xi.job.BLM or mJob == xi.job.RNG then
                            player:setPos(-511.459, 159.004, -210.543, 10, 139)
                        elseif mJob == xi.job.PLD or mJob == xi.job.DRK or mJob == xi.job.BRD then
                            player:setPos(-225.146, -24.250, 20.057, 255, 206)
                        elseif mJob == xi.job.RDM or mJob == xi.job.THF or mJob == xi.job.BST then
                            player:setPos(-349.899, 104.213, -260.150, 0, 144)
                        elseif mJob == xi.job.SAM or mJob == xi.job.NIN or mJob == xi.job.DRG then
                            player:setPos(-220.084, -0.645, 4.442, 191, 168)
                        end
                    end
                end,

                [93] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLevelCap(75)
                        player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_75)
                    end
                end,
            },
        },
    },
}

return quest
