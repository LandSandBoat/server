-----------------------------------
-- Zone: The Eldieme Necropolis (195)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------

-- Handle 7 Sins Skeleton NMs Spawns
local skullTrade = function(player, npc)
    local candleCount =
    {
        ID.text.SKULL_FIVE_REMAIN,
        ID.text.SKULL_FOUR_REMAIN,
        ID.text.SKULL_THREE_REMAIN,
        ID.text.SKULL_TWO_REMAIN,
        ID.text.SKULL_ONE_REMAIN,
        ID.text.SKULL_SPAWN,
    }

    local tradeCount = GetNPCByID(ID.npc.CANDLE_OFFSET):getLocalVar('SkullTradeCount')  -- Track how many candles have been lit
    local tradeWindow = GetNPCByID(ID.npc.CANDLE_OFFSET):getLocalVar('SkullTradeTimer') -- Track how much time before candles reset
    local active = npc:getLocalVar('candleActive')                                      -- Track if current candle has already been lit

    for i = 1, 5 do
        if tradeCount == 6 and os.time() < tradeWindow and os.time() > active then         -- Final candle, spawn Skulls
            GetNPCByID(ID.npc.CANDLE_OFFSET):setLocalVar('SkullTradeCount', 0)
            GetNPCByID(ID.npc.CANDLE_OFFSET):setLocalVar('SkullRespawn', os.time() + 3600) -- 1 hour cooldown to respawn skulls
            player:messageSpecial(ID.text.SKULL_SPAWN)
            player:confirmTrade()

            -- Spawn all 7 Skulls
            for skull = 1, 7 do
                SpawnMob(ID.mob.LICH_C_MAGNUS + skull) -- IDs based off Lich C Magnus
            end

            break
        elseif tradeCount == i and os.time() < tradeWindow and os.time() > active then -- Candle trades 2 through 6
            GetNPCByID(ID.npc.CANDLE_OFFSET):setLocalVar('SkullTradeCount', i + 1)
            npc:setLocalVar('candleActive', os.time() + 10)
            player:messageSpecial(ID.text.THE_BRAZIER_IS_LIT)
            player:messageSpecial(candleCount[i])
            player:confirmTrade()
            break
        elseif os.time() > tradeWindow and os.time() > active then -- First candle trade to start timer
            GetNPCByID(ID.npc.CANDLE_OFFSET):setLocalVar('SkullTradeCount', 1)
            GetNPCByID(ID.npc.CANDLE_OFFSET):setLocalVar('SkullTradeTimer', os.time() + 40)
            npc:setLocalVar('candleActive', os.time() + 10)
            player:messageSpecial(ID.text.THE_BRAZIER_IS_LIT)
            player:messageSpecial(ID.text.SKULL_SIX_REMAIN)
            player:confirmTrade()
            break
        end
    end
end

local eldiemeGlobal =
{
    -- Click on any of the intersection gates
    gateOnTrigger = function(player, npc)
        if npc:getAnimation() == xi.anim.CLOSE_DOOR then
            if player:hasKeyItem(xi.ki.MAGICKED_ASTROLABE) then
                npc:openDoor(8)
            else
                player:messageSpecial(ID.text.SOLID_STONE)
            end
        end
    end,

    -- Click on any of the switch plates
    plateOnTrigger = function(npc)
        -- toggle gates between open and close animations
        -- gates are grouped in groups of five. even numbered groups share one animation, while odd numbered groups share the other.

        local animEven = (npc:getAnimation() == xi.anim.OPEN_DOOR) and xi.anim.CLOSE_DOOR or xi.anim.OPEN_DOOR
        local animOdd  = (npc:getAnimation() == xi.anim.OPEN_DOOR) and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR

        for i = 0, 19 do
            local group = math.floor(i / 5)
            local anim = (group % 2 == 0) and animEven or animOdd
            GetNPCByID(ID.npc.GATE_OFFSET + i):setAnimation(anim)
        end

        -- toggle plates between open and close animations
        for i = 20, 27 do
            GetNPCByID(ID.npc.GATE_OFFSET + i):setAnimation(animEven)
        end
    end,

    handleCandleTrade = function(player, npc, trade)
        local timer = GetNPCByID(ID.npc.CANDLE_OFFSET):getLocalVar('SkullRespawn') -- 1 hour cooldown to respawn skulls

        if
            npcUtil.tradeHasExactly(trade, xi.item.FLINT_STONE) and
            os.time() > timer
        then
            skullTrade(player, npc)
        elseif os.time() < timer then
            player:messageSpecial(ID.text.BRAZIER_COOLDOWN)
        end
    end,

    handleCandleTrigger = function(player, npc)
        local timer = GetNPCByID(ID.npc.CANDLE_OFFSET):getLocalVar('SkullRespawn') -- 1 hour cooldown to respawn skulls
        local active = npc:getLocalVar('candlesActive')

        if os.time() < active then
            player:messageSpecial(ID.text.BRAZIER_ACTIVE)
        elseif os.time() > timer and os.time() > active then
            player:messageSpecial(ID.text.BRAZIER_OUT, 0, xi.item.FLINT_STONE)
        else
            player:messageSpecial(ID.text.BRAZIER_COOLDOWN)
        end
    end
}

return eldiemeGlobal
