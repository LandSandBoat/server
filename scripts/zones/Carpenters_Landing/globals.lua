-----------------------------------
-- Zone: Carpenters' Landing (2)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
require("scripts/globals/npc_util")
-----------------------------------

local carpentersLandingGlobal =
{
    --[[..............................................................................................
        called once at server start, then every 7:00 and 22:00
        ..............................................................................................]]
    herculesTreeOnGameHour = function()
        local hour = VanadielHour()
        local stat = xi.status.NORMAL

        if hour >= 7 and hour < 22 then
            stat = xi.status.DISAPPEAR
        else
            GetMobByID(ID.mob.HERCULES_BEETLE):setLocalVar("hasSpawned", 0)
        end

        for _, v in pairs(ID.npc.HERCULES_BEETLE_TREES) do
            local tree = GetNPCByID(v)
            if tree then
                tree:setLocalVar("honey", 0)
                tree:setStatus(stat)
            end
        end
    end,

    --[[..............................................................................................
        trade to any of the six trees that can spawn Hercules Beetle
        ..............................................................................................]]
    herculesTreeOnTrade = function(player, npc, trade)
        local msgOffset = ID.text.HERCULES_TREE_NOTHING_YET

        if npcUtil.tradeHas(trade, 4370) then
            if npc:getLocalVar("honey") == 0 then
                player:messageSpecial(msgOffset + 4, 4370) -- "You plaster the contents of a pot of honey on the tree."

                local hour = VanadielHour()
                npc:setLocalVar("honey", (hour >= 22 or hour < 4) and 1 or 2) -- 1 = trade was done in time (before 4am). 2 = trade was too late.
                player:confirmTrade()
            else
                player:messageSpecial(msgOffset + 1, 4370) -- "The bark is sticky. The tree has already been plastered with the contents of a pot of honey."
            end
        end
    end,

    --[[..............................................................................................
        trigger any of the six trees that can spawn Hercules Beetle
        ..............................................................................................]]
    herculesTreeOnTrigger = function(player, npc)
        local msgOffset = ID.text.HERCULES_TREE_NOTHING_YET
        local honey     = npc:getLocalVar("honey")
        local hour      = VanadielHour()

        if npc:getLocalVar("honey") == 0 then
            player:messageSpecial(msgOffset + 2) -- "You smell something sweet."
        else
            if hour >= 22 or hour < 4 then
                player:messageSpecial(msgOffset) -- "There is nothing here yet. Check again in the morning."
            else
                local mob = GetMobByID(ID.mob.HERCULES_BEETLE)
                if
                    honey == 1 and
                    math.random(1, 100) <= 20 and
                    mob:getLocalVar("hasSpawned") == 0 and
                    npcUtil.popFromQM(player, npc, ID.mob.HERCULES_BEETLE, { radius = 5, hide = 0 })
                then
                    mob:setLocalVar("hasSpawned", 1)
                else
                    player:messageSpecial(msgOffset + 3) -- "You did not catch anything."
                end

                npc:setStatus(xi.status.DISAPPEAR)
            end
        end
    end
}

return carpentersLandingGlobal
