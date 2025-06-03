-----------------------------------
-- Area: Quicksand Caves
--  NPC: Ornate Door
-- Door blocked by Weight system
-- !pos 21 0 -180 208
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local difX = player:getXPos()-(30)
    local difZ = player:getZPos()-(-180)
    local Distance = math.sqrt(math.pow(difX, 2) + math.pow(difZ, 2))
    if Distance < 3 then
        return -1
    end

    player:messageSpecial(ID.text.DOOR_FIRMLY_SHUT)
end

return entity
