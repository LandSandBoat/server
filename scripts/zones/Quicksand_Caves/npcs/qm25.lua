-----------------------------------
-- Area: Quicksand Caves
--  NPC: qm25
--  Notes: Antican Tag
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if npcUtil.giveItem(player, xi.item.ANTICAN_TAG) then
        local newPosition = npcUtil.pickNewPosition(npc:getID(), ID.npc.ANTICAN_TAG_POSITIONS, true)
        npc:hideNPC(7200)
        npc:setPos(newPosition.x, newPosition.y, newPosition.z)
        SetServerVariable('[POP]Antican_Tag', os.time() + 7200) -- "pause" UpdateNPCSpawnPoint
    end
end

return entity
