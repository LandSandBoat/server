-----------------------------------
-- Breaking the Bonds of Fate
-- Corsair Limit Break Quest
-----------------------------------
-- Log ID: 6, Quest ID: 41
-- qm6 (H-10/Boat)  : !pos 468.767 -12.292 111.817 54
-----------------------------------
local arrapagoID    = zones[xi.zone.ARRAPAGO_REEF]
local talaccaCoveID = zones[xi.zone.TALACCA_COVE]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.BREAKING_THE_BONDS_OF_FATE)

quest.reward =
{
    title = xi.title.MASTER_OF_CHANCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) and
                player:getMainJob() == xi.job.COR and
                player:getMainLvl() >= 66
        end,

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(234)
                end,
            },

            onEventFinish =
            {
                [234] = function(player, csid, option, npc)
                    if option == 0 then
                        return quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:getMainJob() == xi.job.COR and
                player:getMainLvl() >= 66
        end,

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm6'] =
            {
                onTrade = function(player, npc, trade)
                    if trade:getItemQty(xi.item.CORSAIRS_TESTIMONY) > 0 then
                        return quest:progressEvent(235, { [7] = 1 })
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:messageSpecial(arrapagoID.text.YOU_MUST_BRING, xi.item.CORSAIRS_TESTIMONY)
                end,
            },

            onEventFinish =
            {
                [235] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                        player:setPos(-100.166, -7.701, -091.059, 197, xi.zone.TALACCA_COVE)
                    end
                end,
            },
        },

        [xi.zone.TALACCA_COVE] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.BREAKING_THE_BONDS_OF_FATE then
                        if player:getLevelCap() == 70 then
                            player:setLevelCap(75)
                            player:messageSpecial(talaccaCoveID.text.YOUR_LEVEL_LIMIT_IS_NOW_75)
                        end

                        npcUtil.giveItem(player, { xi.item.SCROLL_OF_INSTANT_WARP })
                        quest:complete(player)
                    end
                end,
            },
        },

    },
}

return quest
