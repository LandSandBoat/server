-----------------------------------
-- Zone: The Eldieme Necropolis (195)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------
local spawnSkulls = function()
    -- Spawn all 7 Skulls
    for skull = 1, 7 do
        SpawnMob(ID.mob.LICH_C_MAGNUS + skull) -- IDs based off Lich C Magnus
    end

    -- Used to stop Skulls from being spawned until an hour from being spawned
    SetServerVariable('[ELDIEME]TimeToRespawnSkulls', os.time() + 3600)
end

local brazierMessages =
{
    ID.text.SKULL_SPAWN,
    ID.text.SKULL_ONE_REMAIN,
    ID.text.SKULL_TWO_REMAIN,
    ID.text.SKULL_THREE_REMAIN,
    ID.text.SKULL_FOUR_REMAIN,
    ID.text.SKULL_FIVE_REMAIN,
    ID.text.SKULL_SIX_REMAIN,
}

local countUnlitBraziers = function()
    local numberNotLit = 7

    for i = 0, 6 do
        local brazier = GetNPCByID(ID.npc.CANDLE_OFFSET + i)
        if brazier and brazier:getAnimation() == xi.anim.OPEN_DOOR then
            numberNotLit = numberNotLit - 1
        end
    end

    return numberNotLit
end

local lightBrazier = function(player, npc)
    npc:setAnimation(xi.anim.OPEN_DOOR)

    --unlight brazier after five minutes
    npc:timer(300000, function()
        npc:setAnimation(xi.anim.CLOSE_DOOR)
    end)

    player:messageSpecial(ID.text.THE_BRAZIER_IS_LIT)

    local numberNotLit = countUnlitBraziers()
    local messageAfterLightingBrazier = brazierMessages[numberNotLit + 1]

    player:messageSpecial(messageAfterLightingBrazier)

    if numberNotLit == 0 then
        spawnSkulls()
    end
end

local eldiemeGlobal = {
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
        if
            os.time() > GetServerVariable('[ELDIEME]TimeToRespawnSkulls') and
            npcUtil.tradeHasExactly(trade, xi.item.FLINT_STONE)
        then
            lightBrazier(player, npc)
        else
            player:messageSpecial(ID.text.NOTHING_HAPPENED)
        end
    end,

    handleCandleTrigger = function(player, npc)
        if npc:getAnimation() == xi.anim.OPEN_DOOR then
            player:messageSpecial(ID.text.BRAZIER_ACTIVE)
        elseif os.time() > GetServerVariable('[ELDIEME]TimeToRespawnSkulls') then
            player:messageSpecial(ID.text.BRAZIER_OUT, 0, xi.item.FLINT_STONE)
        else
            player:messageSpecial(ID.text.BRAZIER_COOLDOWN)
        end
    end,
}

return eldiemeGlobal
