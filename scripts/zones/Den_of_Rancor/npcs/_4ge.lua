-----------------------------------
-- Area: Den of Rancor
-- NPC: Altar of Rancor
-- Note: Used to spawn NM Rancor Torch
-- Only Accepts Rancor Flame
-- Lanterns do not turn off until the NM is spawned and despawns
-- !pos 116.448 16.000 -318.659
-----------------------------------
local denOfRancorID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Early return: No correct item in trade.
    if not npcUtil.tradeHas(trade, xi.item.RANCOR_FLAME) then -- Rancor Flame
        return
    end

    -- Early return: No NM entity.
    local rancorTorch = GetMobByID(denOfRancorID.mob.RANCOR_TORCH)
    if not rancorTorch then
        return
    end

    -- Early return: NM is already spawned
    if rancorTorch:isSpawned() then
        player:messageSpecial(denOfRancorID.text.LANTERN_ALREADY_LIT)
        return
    end

    player:confirmTrade()
    player:addItem(xi.item.UNLIT_LANTERN) -- return unlit lantern

    local offset = denOfRancorID.npc.LANTERN_OFFSET + 15
    for npcId = offset, offset + 3 do
        local lantern = GetNPCByID(npcId)

        if
            lantern and
            lantern:getAnimation() == xi.anim.CLOSE_DOOR
        then
            lantern:setAnimation(xi.anim.OPEN_DOOR) -- light lantern
            player:messageSpecial(denOfRancorID.text.ONE_OF_THE_LANTERNS + npcId - offset)
            if npcId == offset + 3 then
                player:messageSpecial(denOfRancorID.text.TANSFORMED_INTO_A_MONSTER)
                SpawnMob(denOfRancorID.mob.RANCOR_TORCH):updateClaim(player)
            end

            break -- Breaks the loop once a lantern has been lit
        end
    end
end

-- Message changes depending on how many lanterns are lit
entity.onTrigger = function(player, npc)
    local count = 0
    local offset = denOfRancorID.npc.LANTERN_OFFSET + 15

    for npcId = offset, offset + 3 do
        local lantern = GetNPCByID(npcId)

        if
            lantern and
            lantern:getAnimation() == xi.anim.OPEN_DOOR
        then
            count = count + 1
        end
    end

    player:messageSpecial(denOfRancorID.text.RUSTY_OLD_LANTERN + count)
end

return entity
