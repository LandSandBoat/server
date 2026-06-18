-----------------------------------
-- Module: Elemental Grip Trade
--   Area: Aht Urhgan Whitegate
--    NPC: Wondrix
-- Desc: Trade all 8 elemental grips to receive a Magic Strap.
--       Then trade a Magic Strap + 3 T3 ZNM trophies for an augmented Magic Strap.
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------

xi = xi or {}
xi.elementalGripTrade = xi.elementalGripTrade or {}

local grips =
{
    xi.item.FIRE_GRIP,
    xi.item.WATER_GRIP,
    xi.item.WIND_GRIP,
    xi.item.ICE_GRIP,
    xi.item.THUNDER_GRIP,
    xi.item.EARTH_GRIP,
    xi.item.LIGHT_GRIP,
    xi.item.DARK_GRIP,
}

local t3ZeniTrophies =
{
    xi.item.ARMED_GEARS_FRAGMENT,
    xi.item.GOTOH_ZHAS_NECKLACE,
    xi.item.DEAS_HORN,
    xi.item.NOSFERATUS_CLAW,
    xi.item.BHURBORLORS_VAMBRACE,
    xi.item.ACHAMOTHS_ANTENNA,
    xi.item.MAHJLAEFS_STAFF,
    xi.item.EXPERIMENTAL_LAMIAS_ARMBAND,
    xi.item.NUHNS_ESCA,
}

local varTradedGrips = '[MagicStrap]hasTradedGrips'

local function hasAugmentedStrap(player)
    if player:hasItem(xi.item.MAGIC_STRAP) then
        local magicStrap        = player:findItem(xi.item.MAGIC_STRAP)
        local augmentId, _      = unpack(magicStrap:getAugment(0))

        if augmentId > 0 then
            return true
        end
    end

    return false
end

local function countTradedTrophies(trade)
    local count = 0

    for _, itemID in ipairs(t3ZeniTrophies) do
        if npcUtil.tradeHas(trade, itemID) then
            count = count + 1
        end
    end

    return count
end

xi.elementalGripTrade.onTrade = function(player, npc, trade)
    local augmentedStrap = hasAugmentedStrap(player)
    local tradedGrips    = player:getVar(varTradedGrips) > 0

    -- Step 1: Trade all 8 elemental grips
    if
        not augmentedStrap and
        not tradedGrips and
        npcUtil.tradeHasExactly(trade, grips)
    then
        player:confirmTrade()
        player:setVar(varTradedGrips, 1)
        player:printToPlayer('Oh, this will do nicely...', xi.msg.channel.SAY, 'Wondrix')
        player:queue(1000, function(p)
            p:printToPlayer('What, did you think you were done? Bring me a Magic Strap and three of the rarer trophies Sanraku is askin\' for.', xi.msg.channel.SAY, 'Wondrix')
        end)

    -- Step 2: Trade Magic Strap + 3 T3 ZNM trophies
    elseif not augmentedStrap and tradedGrips then
        local trophyCount = countTradedTrophies(trade)

        if
            trophyCount >= 3 and
            npcUtil.tradeHas(trade, xi.item.MAGIC_STRAP)
        then
            player:confirmTrade()
            player:setVar(varTradedGrips, 0)
            player:printToPlayer('Excellent... Pleasure doin\' business with ya.', xi.msg.channel.SAY, 'Wondrix')
            player:addItem({ id = xi.item.MAGIC_STRAP, augments = { { [0] = xi.augment.MAG_ACC_P1, [1] = 1 } } })
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, xi.item.MAGIC_STRAP)
        end
    end
end

xi.elementalGripTrade.onTrigger = function(player, npc)
    local augmentedStrap = hasAugmentedStrap(player)
    local tradedGrips    = player:getVar(varTradedGrips) > 0

    if not augmentedStrap and not tradedGrips then
        player:queue(1000, function(p)
            p:printToPlayer('I\'m on the lookout for loot from those critters that Sanraku fella won\'t shut up about.', xi.msg.channel.SAY, 'Wondrix')
        end)

        -- Hint if player owns any elemental grip
        for _, itemID in ipairs(grips) do
            if player:hasItem(itemID) then
                player:queue(2000, function(p)
                    p:printToPlayer('Actually... What\'s that you got there? An elemental grip? If you bring me a full set I can make something nice.', xi.msg.channel.SAY, 'Wondrix')
                end)

                break
            end
        end
    elseif not augmentedStrap then
        player:queue(1000, function(p)
            p:printToPlayer('What, did you think you were done? Bring me a Magic Strap and three of the rarer trophies Sanraku is asking for.', xi.msg.channel.SAY, 'Wondrix')
        end)
    end
end

return xi.elementalGripTrade
