-----------------------------------
-- Achieving True Power
-----------------------------------
-- Log ID: 1, Quest ID: 85
-----------------------------------
local navukgoID = zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.ACHIEVING_TRUE_POWER)

quest.reward =
{
    title = xi.title.MASTER_OF_MANIPULATION,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES) and
                player:getMainJob() == xi.job.PUP and
                player:getMainLvl() >= 66
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Shamarhaan'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(441, xi.automaton.getModelId(player))
                end,
            },

            onEventFinish =
            {
                [441] = function(player, csid, option, npc)
                    return quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:getMainJob() == xi.job.PUP and
                player:getMainLvl() >= 66
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Shamarhaan'] =
            {
                onTrade = function(player, npc, trade)
                    if trade:getItemQty(xi.item.PUPPETMASTERS_TESTIMONY) > 0 then
                        return quest:progressEvent(443)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(442)
                end,
            },

            onEventFinish =
            {
                [443] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:setPos(-659.106, -9.126, -194.577, 213, xi.zone.NAVUKGO_EXECUTION_CHAMBER)
                end,
            },
        },

        [xi.zone.NAVUKGO_EXECUTION_CHAMBER] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.ACHIEVING_TRUE_POWER then
                        if player:getLevelCap() == 70 then
                            player:setLevelCap(75)
                            player:messageSpecial(navukgoID.text.YOUR_LEVEL_LIMIT_IS_NOW_75)
                        end

                        npcUtil.giveItem(player, { xi.item.SCROLL_OF_INSTANT_WARP })
                        quest:complete(player)
                    end
                end,
            },
        },

    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Shamarhaan'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(444):replaceDefault()
                end,
            },
        },
    },
}

return quest
