-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Obtain KI Cast Metal Plate)
-- !pos 850.894 -15.732 318.294 61
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
---@type TNpcEntity
local entity = {}

local castMetalPlatePos =
{
    [1]  =  { 464.94,  -14.651,  -52.484 },
    [2]  =  { 586.903, -24.707,  225.11  },
    [3]  =  { 616.923, -24.094,  102.68  },
    [4]  =  { 805.211, -22.077,  325.652 },
    [5]  =  { 721.256, -21.924,  -13.244 },
    [6]  =  { 601.431, -17.891,   14.779 },
    [7]  =  { 180.847, -13.512, -173.366 },
    [8]  =  { 277.292, -18.142, -297.013 },
    [9]  =  { 389.333, -15.236, -252.645 },
    [10] =  { 850.894, -15.732,  318.294 },
} -- TODO Capture spawn points for cast metal plate. 1, 8, 10 are known.

entity.onSpawn = function(npc)
    npc:setPos(unpack(castMetalPlatePos[math.randomInt(1, 10)]))
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('HalvungDoor') == 1 then
        player:addKeyItem(xi.ki.CAST_METAL_PLATE)
        player:messageSpecial(ID.text.FITS_LARGE_KEYHOLE, xi.ki.CAST_METAL_PLATE)
        player:setCharVar('HalvungDoor', 0)
        npc:setPos(unpack(castMetalPlatePos[math.randomInt(1, 10)]))
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
