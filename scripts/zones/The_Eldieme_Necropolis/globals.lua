-----------------------------------
-- Zone: The Eldieme Necropolis (195)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
-----------------------------------
local function lightCandle(player, npc)
    -- Handle 7 Sins Skeleton NMs Spawns
    local zone = npc:getZone()
    local skullRespawn = zone:getLocalVar("SkullRespawn")
    local candleOffset = ID.npc.TALLOW_CANDLE_OFFSET
    local candlesLit = 0
    local candleText =
    {
        ID.text.SKULL_SIX_REMAIN,
        ID.text.SKULL_FIVE_REMAIN,
        ID.text.SKULL_FOUR_REMAIN,
        ID.text.SKULL_THREE_REMAIN,
        ID.text.SKULL_TWO_REMAIN,
        ID.text.SKULL_ONE_REMAIN,
        ID.text.SKULL_SPAWN,
    }

    -- If this candle is already lit, then don't change anything (Do we tell player?)
    if npc:getAnimation() == xi.anim.OPEN_DOOR then
        return
    else
        player:messageSpecial(ID.text.THE_BRAZIER_IS_LIT)
        npc:setAnimation(xi.anim.OPEN_DOOR)
        npc:timer(300000, function(candle)
            candle:setAnimation(xi.anim.CLOSE_DOOR)
        end)
    end

    -- Find the lit candles
    for i = 0, 6 do
        local candle = GetNPCByID(candleOffset + i)
        -- If (candle is lit) then increment lit counter
        if candle:getAnimation() == xi.anim.OPEN_DOOR then
            candlesLit = candlesLit + 1
        end
    end

    -- Present message to player based on # of lit candles
    player:messageSpecial(candleText[candlesLit])

    if
        candlesLit == 7 and
        os.time() > skullRespawn
    then -- Final candle, spawn Skulls
        zone:setLocalVar("SkullRespawn", os.time() + 3600) -- One-hour respawn timer

        -- Spawn all 7 Skulls
        for skull = 1, 7 do
            SpawnMob(ID.mob.SKULL_OFFSET + skull)
        end

    elseif
        candlesLit == 7 and
        os.time() <= skullRespawn
    then -- ??? Unknown Edge case.  ToDo?
        return
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

    candleOnTrade = function(player, npc, trade)
        local zone = npc:getZone()
        local skullRespawn = zone:getLocalVar("SkullRespawn") or 0 -- 1 hour cooldown to respawn skulls

        if
            npcUtil.tradeHasExactly(trade, xi.items.FLINT_STONE) and
            os.time() > skullRespawn
        then
            lightCandle(player, npc)
        elseif os.time() < skullRespawn then
            player:messageSpecial(ID.text.BRAZIER_COOLDOWN)
        end
    end,

    candleOnTrigger = function(player, npc)
        local zone = npc:getZone()
        local skullRespawn = zone:getLocalVar("SkullRespawn") -- 1 hour cooldown to respawn skulls

        if npc:getAnimation() == xi.anim.OPEN_DOOR then
            player:messageSpecial(ID.text.BRAZIER_ACTIVE)
        elseif os.time() > skullRespawn then
            player:messageSpecial(ID.text.BRAZIER_OUT, 0, xi.items.FLINT_STONE)
        else
            player:messageSpecial(ID.text.BRAZIER_COOLDOWN)
        end
    end,
}

return eldiemeGlobal
