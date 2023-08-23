-----------------------------------
--
--     Corrects the amount of Conquest rewarded from Crystal trade ins
--
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/zone")
require("scripts/globals/garrison")
-----------------------------------

local m = Module:new("conquest_crystal_trade_fix")

xi = xi or {}
xi.conquest = xi.conquest or {}

local crystals =
{
    [4096] = 12,
    [4097] = 12,
    [4098] = 12,
    [4099] = 12,
    [4100] = 12,
    [4101] = 12,
    [4102] = 16,
    [4103] = 16,
    [4238] = 12,
    [4239] = 12,
    [4240] = 12,
    [4241] = 12,
    [4242] = 12,
    [4243] = 12,
    [4244] = 16,
    [4245] = 16,
}

local expRings =
{
    [15761] = {cp=350, charges=7},
    [15762] = {cp=700, charges=7},
    [15763] = {cp=600, charges=3},
}

m:addOverride("xi.conquest.overseerOnTrade", function(player, npc, trade, guardNation, guardType)
    -- Garrison Trade
    if 
        guardType == xi.conq.guard.OUTPOST and 
        (trade:getItemId() >= 1528 and trade:getItemId() <= 1543) 
    then
        xi.garrison.onTrade(player, npc, trade, guardNation)
    end

    if player:getNation() == guardNation or guardNation == xi.nation.OTHER then
        local item = trade:getItemId()
        local tradeConfirmed = false
        local mOffset = zones[player:getZoneID()].text.CONQUEST

        -- DONATE CRYSTALS FOR RANK OR CONQUEST POINTS
        if guardType <= xi.conquest.guard.FOREIGN and crystals[item] then
            local pRank = player:getRank(player:getNation())
            local pRankPoints = player:getRankPoints()
            local addPoints = 0

            for crystalId, crystalWorth in pairs(crystals) do
                local count = trade:getItemQty(crystalId)

                if count > 0 then
                    if pRank == 1 then
                        player:showText(npc, mOffset - 7) -- "I cannot accept crystals from someone whose rank is still 1."
                        break
                    elseif pRankPoints == 4000 then
                        player:showText(npc, mOffset + 43) -- "You do not need to donate any more crystals at your current rank."
                        break
                    else
                        trade:confirmItem(crystalId, count)
                        addPoints = addPoints + count * math.floor(4000 / (player:getRank(player:getNation()) * 12 - crystalWorth))
                    end
                end
            end

            if addPoints > 0 and pRank ~= 1 and pRankPoints < 4000 then
                if pRankPoints + addPoints >= 4000 then
                    player:setRankPoints(4000)
                    player:addCP((pRankPoints + (addPoints) - 4000)/14)
                    player:showText(npc, mOffset + 44) -- "Your rank points are full. We've added the excess to your conquest points."
                else
                    player:addRankPoints(addPoints)
                    player:showText(npc, mOffset + 45) -- "We've awarded you rank points for the crystals you've donated."
                end
                player:confirmTrade()
                tradeConfirmed = true
            end
        end

        -- RECHARGE EXP RING
        if not tradeConfirmed and expRings[item] and npcUtil.tradeHas(trade, item) then
            if xi.settings.BYPASS_EXP_RING_ONE_PER_WEEK == 1 or player:getCharVar("CONQUEST_RING_RECHARGE") < os.time() then
                local ring = expRings[item]

                if player:getCP() >= ring.cp then
                    player:delCP(ring.cp)
                    player:confirmTrade()
                    player:addItem(item)
                    player:setCharVar("CONQUEST_RING_RECHARGE", getConquestTally())
                    player:showText(npc, mOffset + 58, item, ring.cp, ring.charges) -- "Your ring is now fully recharged."
                else
                    player:tradeComplete(false)
                    player:showText(npc, mOffset + 55, item, ring.cp) -- "You do not have the required conquest points to recharge."
                end
            else
                -- TODO: Verify that message is retail correct.
                -- This gives feedback on a failure at least, and is grouped with the recharge messages.  Confident enough for a commit.
                player:tradeComplete(false)
                player:showText(npc, mOffset + 56, item) -- "Please be aware that you can only purchase or recharge <item> once during the period between each conquest results tally.
            end
        end
    end
end)

return m
