-----------------------------------
-- The Beast Within
-----------------------------------
-- Log ID: 6, Quest ID: 40
-- Waoud: !pos 65 -6 -78 50
-----------------------------------
local whitegateID     = zones[xi.zone.AHT_URHGAN_WHITEGATE]
local jadeSepulcherID = zones[xi.zone.JADE_SEPULCHER]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_BEAST_WITHIN)

quest.reward =
{
    title = xi.title.MASTER_OF_AMBITION,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS) and
                player:getMainJob() == xi.job.BLU and
                player:getMainLvl() >= 66
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(760)
                end,
            },

            onEventFinish =
            {
                [760] = function(player, csid, option, npc)
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
                player:getMainJob() == xi.job.BLU and
                player:getMainLvl() >= 66
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(761)
                end,
            },

            ['Imperial_Whitegate'] =
            {
                onTrade = function(player, npc, trade)
                    if trade:getItemQty(xi.item.BLUE_MAGES_TESTIMONY) > 0 then
                        if quest:getVar(player, 'Prog') == 2 then
                            return quest:progressEvent(763)
                        else
                            return quest:progressEvent(762)
                        end
                    end
                end,
            },

            onEventUpdate =
            {
                [761] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(player:getGil()) -- The event automtically gives the correct option depending on the player's gil.
                    end
                end,
            },

            onEventFinish =
            {
                [761] = function(player, csid, option, npc)
                    if option ~= 1 then
                        return
                    end

                    if player:getGil() < 1000 then
                        return
                    end

                    player:delGil(1000)
                    player:messageSpecial(whitegateID.text.PAY_DIVINATION)
                end,

                [762] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                        player:setPos(300.280, -0.853, -177.745, 63, 67) -- Teleport to Jade Sepulcher
                    end
                end,

                [763] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setPos(300.280, -0.853, -177.745, 63, 67) -- Teleport to Jade Sepulcher
                    end
                end,
            },
        },

        [xi.zone.JADE_SEPULCHER] =
        {
            onZoneIn = function(player, prevZone)
                if quest:getVar(player, 'Prog') == 1 then
                    return 2
                end
            end,

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [6] = function(player, csid, option, npc)
                    if player:getLevelCap() == 70 then
                        player:setLevelCap(75)
                        player:messageSpecial(jadeSepulcherID.text.YOUR_LEVEL_LIMIT_IS_NOW_75)
                    end

                    npcUtil.giveItem(player, { xi.item.SCROLL_OF_INSTANT_WARP })
                    quest:complete(player)
                end,

                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.BEAST_WITHIN then
                        player:startEvent(6)
                    end
                end,
            },
        },

    },
}

return quest
