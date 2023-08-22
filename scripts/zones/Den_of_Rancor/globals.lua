-- Zone: Den of Rancor (160)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/npc_util")
-----------------------------------

local denOfRancorGlobal =
{
    --[[..............................................................................................
        trade to lanterns next to Sacrificial Chamber (Rancor Flame)
        ..............................................................................................]]
    onTradeLanternChamber = function(player, npc, trade)
        if npcUtil.tradeHas(trade, 1139) then -- Rancor Flame
            if npc:getAnimation() == xi.anim.OPEN_DOOR then
                player:messageSpecial(ID.text.LANTERN_OFFSET + 7) -- already lit
            else
                player:confirmTrade()
                player:addItem(1138) -- return unlit lantern

                npc:openDoor(xi.settings.main.LANTERNS_STAY_LIT) -- light lantern

                local total = GetNPCByID(ID.npc.LANTERN_OFFSET + 0):getAnimation() +
                    GetNPCByID(ID.npc.LANTERN_OFFSET + 1):getAnimation() +
                    GetNPCByID(ID.npc.LANTERN_OFFSET + 2):getAnimation() +
                    GetNPCByID(ID.npc.LANTERN_OFFSET + 3):getAnimation()

                player:messageSpecial(ID.text.LANTERN_OFFSET + 44 - total)

                if total == 32 then
                    for i = ID.npc.LANTERN_OFFSET, ID.npc.LANTERN_OFFSET + 3 do
                        local lantern = GetNPCByID(i)
                        lantern:closeDoor(1)
                        lantern:openDoor(30)
                    end

                    GetNPCByID(ID.npc.LANTERN_OFFSET + 4):openDoor(30)
                end
            end
        end
    end,

    --[[..............................................................................................
        trade to lanterns next to Hakutaku (Rancor Flame)
        ..............................................................................................]]
    onTradeLanternHaku = function(player, npc, trade)
        if npcUtil.tradeHas(trade, 1139) then -- Rancor Flame
            if npc:getAnimation() == xi.anim.OPEN_DOOR then
                player:messageSpecial(ID.text.LANTERN_OFFSET + 7) -- already lit
            else
                player:confirmTrade()
                player:addItem(1138) -- return unlit lantern

                npc:openDoor(xi.settings.main.LANTERNS_STAY_LIT) -- light lantern

                local total = GetNPCByID(ID.npc.LANTERN_OFFSET + 6):getAnimation() +
                    GetNPCByID(ID.npc.LANTERN_OFFSET + 7):getAnimation()

                if total == 17 then
                    player:messageSpecial(ID.text.LANTERN_OFFSET + 9)
                elseif total == 16 then
                    player:messageSpecial(ID.text.LANTERN_OFFSET + 12)
                    for i = ID.npc.LANTERN_OFFSET + 6, ID.npc.LANTERN_OFFSET + 7 do
                        local lantern = GetNPCByID(i)
                        lantern:closeDoor(1)
                        lantern:openDoor(30)
                    end

                    GetNPCByID(ID.npc.LANTERN_OFFSET + 8):openDoor(30)
                end
            end
        end
    end,

    --[[..............................................................................................
        trade to lanterns next to boss room (Flames of Crimson and Blue Rancor)
        ..............................................................................................]]
    onTradeLanternBoss = function(player, npc, trade)
        local itemId = 1131 + npc:getID() - ID.npc.LANTERN_OFFSET

        if npcUtil.tradeHas(trade, itemId) then -- Flame of Crimson or Blue Rancor
            if npc:getAnimation() == xi.anim.OPEN_DOOR then
                player:messageSpecial(ID.text.LANTERN_OFFSET + 7) -- already lit
            else
                player:confirmTrade()
                player:addItem(1138) -- return unlit lantern

                npc:openDoor(xi.settings.main.LANTERNS_STAY_LIT) -- light lantern

                local total = GetNPCByID(ID.npc.LANTERN_OFFSET + 9):getAnimation() +
                    GetNPCByID(ID.npc.LANTERN_OFFSET + 10):getAnimation()

                if total == 17 then
                    player:messageSpecial(ID.text.LANTERN_OFFSET + 9)
                elseif total == 16 then
                    player:messageSpecial(ID.text.LANTERN_OFFSET + 12)
                    for i = ID.npc.LANTERN_OFFSET + 9, ID.npc.LANTERN_OFFSET + 10 do
                        local lantern = GetNPCByID(i)
                        lantern:closeDoor(1)
                        lantern:openDoor(30)
                    end

                    GetNPCByID(ID.npc.LANTERN_OFFSET + 11):openDoor(30)
                end
            end
        end
    end,

    onTriggerLantern = function(player, npc)
        if npc:getAnimation() == xi.anim.OPEN_DOOR then
            player:messageSpecial(ID.text.LANTERN_OFFSET + 7) -- already lit
        else
            player:messageSpecial(ID.text.LANTERN_OFFSET + 20) -- unlit
        end
    end,
}

return denOfRancorGlobal
