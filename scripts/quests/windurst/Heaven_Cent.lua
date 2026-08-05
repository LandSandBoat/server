-----------------------------------
-- Heaven Cent
-----------------------------------
-- !addquest 2 49
-- Ropunono : !pos -51.624 -11.249 117.476 238
-- Mejina-Monjina : !pos -61.924 -11.249 108.022 238
-- Churano-Shurano : !pos -61.624 -11.249 99.650 238
-- Lago-Charago : !pos -57.271 -10.750 92.503 238 (Stellar Map)
-- Iron Door (_5i0) : !pos 247.735 18.499 -142.267 198
-- Coin chest _5i4 : !pos 263.279 18.262 -134.404 198
-- Coin chest _5i5 : !pos 272.142 17.574 -135.766 198
-- Coin chest _5i6 : !pos 273.299 17.928 -138.635 198
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.HEAVEN_CENT)

quest.reward =
{
    title = xi.title.NIGHT_SKY_NAVIGATOR,
}

local mazeID = zones[xi.zone.MAZE_OF_SHAKHRAMI]

-- Maze of Shakhrami coin chests. During the Shelling-Piece stage (Prog 1 or 2),
-- examining a coin chest reveals a random coin -- "You picked up a coin with X
-- drawn to the Y" -- and then asks "Take this coin?" (events 48-50). The player
-- compares the drawn direction against the constellation answer key (Ropunono's
-- hints) and only takes an authentic coin; the coin shown is the one received on
-- "Yes". Retail uses eight coins: four authentic (constellation in its true
-- position) and four counterfeit, drawn at random and independent of which chest
-- (bg-wiki / ffxiclopedia). Taking a counterfeit still gives a (fake) Shelling
-- Piece, which Ropunono later rejects (event 296).
local coinEvents =
{
    ['_5i4'] = 48,
    ['_5i5'] = 49,
    ['_5i6'] = 50,
}

local function pickCoin()
    local coins =
    {
        { message = mazeID.text.COIN_ALEXANDER_NORTHEAST, authentic = true  },
        { message = mazeID.text.COIN_SHIVA_EAST,          authentic = true  },
        { message = mazeID.text.COIN_ODIN_NORTH,          authentic = true  },
        { message = mazeID.text.COIN_IFRIT_NORTHWEST,     authentic = true  },
        { message = mazeID.text.COIN_ODIN_EAST,           authentic = false },
        { message = mazeID.text.COIN_TITAN_NORTH,         authentic = false },
        { message = mazeID.text.COIN_LEVIATHAN_SOUTH,     authentic = false },
        { message = mazeID.text.COIN_SHIVA_WEST,          authentic = false },
    }

    return coins[math.randomInt(1, #coins)]
end

local function coinChestFinish(player, csid, option, npc)
    -- option 1 = "Yes, take it". Only then does the player receive the Shelling
    -- Piece -- the same coin already revealed on examine (authentic or counterfeit).
    if option ~= 1 then
        return
    end

    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(mazeID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.SHELLING_PIECE)
        return
    end

    player:addItem(xi.item.SHELLING_PIECE)
end

local function coinChestTrigger(player, npc)
    local progress = quest:getVar(player, 'Prog')

    if progress ~= 1 and progress ~= 2 then
        return nil
    end

    if player:hasItem(xi.item.SHELLING_PIECE) then
        return quest:messageSpecial(mazeID.text.ALREADY_HAVE_SHELLING_PIECE, xi.item.SHELLING_PIECE)
    end

    -- Reveal a random coin and record whether it is authentic, then ask whether to
    -- take it. The revealed coin is what the player receives on "Yes".
    local coin = pickCoin()

    quest:setVar(player, 'Coin', coin.authentic and 1 or 0)
    player:messageSpecial(coin.message)

    return quest:progressEvent(coinEvents[npc:getName()])
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 5
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ropunono'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(284)
                end,
            },

            onEventFinish =
            {
                [284] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ropunono'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(285)
                    elseif progress == 1 then
                        return quest:event(289, 0, xi.item.AHRIMAN_LENS, xi.item.SHELLING_PIECE)
                    elseif progress == 2 then
                        -- After turning in a forgery: the forgery-aware reminder. The
                        -- Stellar Map (Lago-Charago) is the primary answer-key source.
                        return quest:event(297)
                    end
                end,

                onTrade = function(player, npc, trade)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        progress == 0 and
                        npcUtil.tradeHasExactly(trade, xi.item.AHRIMAN_LENS)
                    then
                        return quest:progressEvent(288, 0, xi.item.AHRIMAN_LENS, xi.item.SHELLING_PIECE)
                    elseif
                        progress >= 1 and
                        npcUtil.tradeHasExactly(trade, xi.item.SHELLING_PIECE)
                    then
                        local coinIsAuthentic = quest:getVar(player, 'Coin') == 1

                        if coinIsAuthentic then
                            return quest:progressEvent(292, 4800 * xi.settings.main.GIL_RATE)
                        else
                            return quest:progressEvent(296)
                        end
                    end
                end,
            },

            ['Mejina-Monjina'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(286)
                    elseif progress == 1 then
                        return quest:event(290, 0, 0, xi.item.SHELLING_PIECE)
                    elseif progress == 2 then
                        return quest:event(298)
                    end
                end,
            },

            ['Churano-Shurano'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(287)
                    elseif progress == 1 then
                        return quest:event(291)
                    elseif progress == 2 then
                        return quest:event(299)
                    end
                end,
            },

            onEventFinish =
            {
                [288] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:confirmTrade()
                end,

                [292] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        -- Gil is shown in the 292 cutscene, so grant it silently here.
                        player:addGil(4800 * xi.settings.main.GIL_RATE)
                    end
                end,

                [296] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'Coin', 0)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            ['_5i4'] = { onTrigger = coinChestTrigger },
            ['_5i5'] = { onTrigger = coinChestTrigger },
            ['_5i6'] = { onTrigger = coinChestTrigger },

            onEventFinish =
            {
                [48] = coinChestFinish,
                [49] = coinChestFinish,
                [50] = coinChestFinish,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        -- Post-quest flavor. Churano's 295 round-robins with his Astrolabe vendor
        -- (both Default priority) -- expected framework behavior; the vendor stays
        -- reachable every other trigger (and once you own the astrolabe his vendor
        -- side is just the brief post-purchase event 280). The 293-299 state-mapping
        -- is inference from wording, not confirmed retail.
        [xi.zone.WINDURST_WATERS] =
        {
            ['Ropunono']        = quest:event(293),
            ['Mejina-Monjina']  = quest:event(294, 0, 0, xi.item.SHELLING_PIECE),
            ['Churano-Shurano'] = quest:event(295),
        },
    },
}

return quest
