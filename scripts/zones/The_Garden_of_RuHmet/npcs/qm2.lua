-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: ??? (Ix'aern (Dark Knight) Spawn)
-- Allows players to spawn the Ix'aern (Dark Knight) by checking ??? only after killing the required mobs in the same room as the ???.
-- !pos -240 5.00 440 35
-- !pos -280 5.00 240 35
-- !pos -560 5.00 239 35
-- !pos -600 5.00 440 35
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local hatedPlayer = npc:getLocalVar("hatedPlayer")
    local isInTime = npc:getLocalVar("hateTimer") > os.time()

    if hatedPlayer ~= 0 and not isInTime then
        -- player took too long, so reset animosity
        npc:setLocalVar("hatedPlayer", 0)
        npc:setLocalVar("hateTimer", 0)
        player:messageSpecial(ID.text.UNKNOWN_PRESENCE)

    elseif hatedPlayer == 0 then
        -- nobody has animosity
        player:messageSpecial(ID.text.UNKNOWN_PRESENCE)

    elseif hatedPlayer ~= player:getID() then
        -- someone else has animosity
        player:messageSpecial(ID.text.NONE_HOSTILE)

    else
        -- this player has animosity
        -- spawn Ix'Aern DRK and its two minions near the QM
        player:messageSpecial(ID.text.MENACING_CREATURES)
        npcUtil.popFromQM(player, npc, {ID.mob.IXAERN_DRK, ID.mob.IXAERN_DRK + 1, ID.mob.IXAERN_DRK + 2}, {radius = 3})

        -- move QM to random location, and reset animosity
        local pos = math.random(1, 4)
        npcUtil.queueMove(npc, ID.npc.IXAERN_DRK_QM_POS[pos])
        npc:setLocalVar("position", pos)
        npc:setLocalVar("hatedPlayer", 0)
        npc:setLocalVar("hateTimer", 0)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
