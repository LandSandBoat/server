-----------------------------------
-- Zone: Misareaux_Coast (25)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Misareaux_Coast/IDs")
require("scripts/globals/npc_util")
-----------------------------------

local misareauxGlobal =
{
    -----------------------------------
    -- Handle spawn/despawn for Ziphius NM QMs
    -----------------------------------
    ziphiusHandleQM = function()
        local vHour = VanadielHour()
        if vHour >= 7 and vHour < 22 then -- Despawn traps for Ziphius
            for i = ID.npc.ZIPHIUS_QM_BASE, ID.npc.ZIPHIUS_QM_BASE + 5 do
                GetNPCByID(i):setStatus(xi.status.DISAPPEAR)
                GetNPCByID(i):resetLocalVars()
            end
        elseif vHour >= 22 or vHour < 4 then -- Spawn traps for Ziphius
            local random = GetNPCByID(ID.npc.ZIPHIUS_QM_BASE + math.random(0, 5))
            if random:getStatus() == xi.status.DISAPPEAR then
                random:setLocalVar("[Ziphius]Spawn", 1)
            end

            for i = ID.npc.ZIPHIUS_QM_BASE, ID.npc.ZIPHIUS_QM_BASE + 5 do
                GetNPCByID(i):setStatus(xi.status.NORMAL)
            end
        elseif vHour == 4 then -- Despawn non-baited traps
            for i = ID.npc.ZIPHIUS_QM_BASE, ID.npc.ZIPHIUS_QM_BASE + 5 do
                if GetNPCByID(i):getLocalVar("[Ziphius]Baited") == 0 then
                    GetNPCByID(i):setStatus(xi.status.DISAPPEAR)
                end
            end
        end
    end,

    -----------------------------------
    -- Trade function for Ziphius NM QMs
    -----------------------------------
    ziphiusOnTrade = function(player, npc, trade)
        local baited = npc:getLocalVar("[Ziphius]Baited") == 1
        if not baited and npcUtil.tradeHas(trade, 16994) then -- Trade Slice of Carp
            npc:setLocalVar("[Ziphius]Bait"..player:getName(), 1)
            npc:setLocalVar("[Ziphius]Baited", 1)
            player:confirmTrade()
            player:messageSpecial(ID.text.PUT_IN_TRAP, 16994)
        end
    end,

    -----------------------------------
    -- Spawn function for Ziphius NM QMs
    -----------------------------------
    ziphiusOnTrigger = function(player, npc)
        local baited = npc:getLocalVar("[Ziphius]Baited") == 1
        local baitedByPlayer = npc:getLocalVar("[Ziphius]Bait"..player:getName()) == 1
        local vHour = VanadielHour()
        if vHour >= 22 or vHour < 4 then
            if not baited then
                player:messageSpecial(ID.text.APPEARS_TO_BE_TRAP)
            elseif baited and baitedByPlayer then
                player:messageSpecial(ID.text.NOTHING_HERE_YET)
            else
                player:messageSpecial(ID.text.ALREADY_BAITED, 16994)
            end
        elseif vHour >= 4 and vHour < 7 then
            if baitedByPlayer then
                if npc:getLocalVar("[Ziphius]Spawn") == 1 then
                    npc:resetLocalVars()
                    npc:setStatus(xi.status.DISAPPEAR)
                    SpawnMob(ID.mob.ZIPHIUS):updateClaim(player)
                    GetMobByID(ID.mob.ZIPHIUS):setPos(npc:getXPos(), npc:getYPos(), npc:getZPos()-1)
                else
                    player:messageSpecial(ID.text.DID_NOT_CATCH_ANYTHING)
                end
            else
                player:messageSpecial(ID.text.ALREADY_BAITED, 16994)
            end
        end
    end,
}

return misareauxGlobal
