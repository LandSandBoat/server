-----------------------------------
-- Say it with Flowers
-----------------------------------
-- Log ID: 2, Quest ID: 50
-- Moari-Kaaori !pos -252 -5 -230
-----------------------------------
local tahrongiID = zones[xi.zone.TAHRONGI_CANYON]
local watersID   = zones[xi.zone.WINDURST_WATERS]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)

local flowerList =
{
    [0] = { itemId = xi.item.CARNATION,  gil = 300 },
    [1] = { itemId = xi.item.RED_ROSE,   gil = 200 },
    [2] = { itemId = xi.item.RAIN_LILY,  gil = 250 },
    [3] = { itemId = xi.item.LILAC,      gil = 150 },
    [4] = { itemId = xi.item.AMARYLLIS,  gil = 200 },
    [5] = { itemId = xi.item.MARGUERITE, gil = 100 },
}

local flowers =
{
    xi.item.CARNATION,
    xi.item.RED_ROSE,
    xi.item.RAIN_LILY,
    xi.item.LILAC,
    xi.item.AMARYLLIS,
    xi.item.MARGUERITE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 2
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moari-Kaaori'] = quest:progressEvent(514),

            onEventFinish =
            {
                [514] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setCharVar('SIWFSword', 1) -- Used to mark that the player has NOT recieved the sword reward yet.
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Prog == 1
        end,

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Tahrongi_Cacti'] =
            {
                onTrigger = function(player, npc)
                    if npcUtil.giveItem(player, xi.item.TAHRONGI_CACTUS, { silent = true }) then -- The player can obtain as many as they want. They are unsellable.
                        return quest:messageSpecial(tahrongiID.text.BUD_BREAKS_OFF, 0, xi.item.TAHRONGI_CACTUS) -- This dialogue does not currently play on retail
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kenapa-Keppa'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        return quest:event(519)
                    end
                end,
            },

            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        return quest:event(517)
                    elseif quest:getMustZone(player) then
                        return quest:progressEvent(518)
                    else
                        return quest:event(516, { [4] = xi.item.TAHRONGI_CACTUS })
                    end
                end,
            },

            ['Moari-Kaaori'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(515)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.TAHRONGI_CACTUS) then
                        if player:getCharVar('SIWFSword') == 1 then
                            return quest:progressEvent(520) -- Player has not received the sword already
                        else
                            return quest:progressEvent(525, 400) -- Player has received the sword already
                        end
                    elseif npcUtil.tradeSetInList(trade, flowers) then
                        return quest:progressEvent(522) -- Player traded a flower that isn't the cactus.
                    end
                end,
            },

            onEventFinish =
            {
                [516] = function(player, csid, option, npc)
                    if option < 7 then
                        local choice = flowerList[option]
                        if
                            choice and
                            player:getGil() >= choice.gil
                        then
                            if npcUtil.giveItem(player, choice.itemId) then
                                player:delGil(choice.gil)
                                quest:setMustZone(player)
                            end
                        else
                            player:messageText(npc, watersID.text.WHAT_DO_YOU_MEAN)
                        end
                    elseif option == 7 then
                        quest:setVar(player, 'Option', 1)
                    end
                end,

                [520] = function(player, csid, option, npc) -- Cactus trade with Iron Sword reward
                    if npcUtil.giveItem(player, xi.item.IRON_SWORD) then
                        quest:complete(player)
                        player:confirmTrade()
                        player:addFame(xi.fameArea.WINDURST, 30)
                        quest:setMustZone(player)
                        quest:setVar(player, 'Stage', 1)
                        player:setCharVar('SIWFSword', 0) -- Removes the var so the player cannot obtain the sword again.
                    end
                end,

                [522] = function(player, csid, option, npc) -- Flower trade
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:addFame(xi.fameArea.WINDURST, 10)
                        player:addGil(100) -- Obtained gil text baked into the cs
                        quest:setMustZone(player)
                    end
                end,

                [525] = function(player, csid, option, npc) -- Cactus trade repeat
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:addFame(xi.fameArea.WINDURST, 30)
                        player:addGil(400) -- Obtained gil text baked into the cs
                        quest:setMustZone(player)
                        quest:setVar(player, 'Stage', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
            vars.Prog == 0
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moari-Kaaori'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(521)
                    elseif quest:getVar(player, 'Stage') == 1 then
                        return quest:progressEvent(685, 0, xi.item.TAHRONGI_CACTUS) -- Player had turned in a cactus
                    else
                        return quest:progressEvent(523) -- Player had turned in a flower
                    end
                end,
            },

            onEventFinish =
            {
                [523] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [685] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },
}

return quest
