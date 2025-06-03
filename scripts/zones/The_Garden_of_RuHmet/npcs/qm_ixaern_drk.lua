-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: qm_ixaern_drk (???)
-- Note: Spawn Ix'aern (DRK) by checking ??? after getting animosity message
--       from killing required mobs in the same room
-- !pos -560 5.00 239 35
-- !pos -600 5.00 440 35
-- !pos -240 5.00 440 35
-- !pos -280 5.00 240 35
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
local gardenGlobal = require('scripts/zones/The_Garden_of_RuHmet/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local hatedPlayer = npc:getLocalVar('hatedPlayer')
    local isInTime = npc:getLocalVar('hateTimer') > os.time()

    if hatedPlayer ~= 0 and not isInTime then
        -- player took too long, so reset animosity
        npc:setLocalVar('hatedPlayer', 0)
        npc:setLocalVar('hateTimer', 0)
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

        -- spawn Ix'DRK last so it retains claim
        npcUtil.popFromQM(player, npc, { ID.mob.IXAERN_DRK + 1, ID.mob.IXAERN_DRK + 2, ID.mob.IXAERN_DRK }, { radius = 3, claim = true })

        -- move QM to random location, and reset animosity
        local pos = math.random(1, 4)
        npcUtil.queueMove(npc, gardenGlobal.qmPosDRKTable[pos])
        npc:setLocalVar('position', pos)
        npc:setLocalVar('hatedPlayer', 0)
        npc:setLocalVar('hateTimer', 0)
    end
end

return entity
