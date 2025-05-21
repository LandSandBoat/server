-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Cermet Alcove
-- Note: Escort Quest
-----------------------------------
local ID = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
-----------------------------------

local escorts =
{
    [ID.npc.CERMET_ALCOVE_OFFSET] =
    {
        ['limit'] = 5,
        ['spawn'] = { x = -260.000, y = -1.000, z = 423.000, rotation = 190 },
    },

    [ID.npc.CERMET_ALCOVE_OFFSET + 1] =
    {
        ['limit'] = 30,
        ['spawn'] = { x = 797.000, y = -1.000, z = 460.000, rotation = 125 },
    },

    [ID.npc.CERMET_ALCOVE_OFFSET + 2] =
    {
        ['limit'] = 30,
        ['spawn'] = { x = 540.000, y = -1.000, z = 297.000, rotation = 60 },
    },

    [ID.npc.CERMET_ALCOVE_OFFSET + 3] =
    {
        ['limit'] = 40,
        ['spawn'] = { x = -540.000, y = -1.000, z = 297.000, rotation = 60 },
    },
}

local entity = {}

entity.onTrigger = function(player, npc)
    local data = escorts[npc:getID()]
    if data == nil then
        return
    end

    local lastId = npc:getLocalVar('QuasiluminId')
    if lastId ~= 0 and GetMobByID(lastId) ~= nil then
        -- Last one for this alcove is still alive
        player:messageSpecial(ID.text.RECENTLY_ACTIVATED)
        return
    end

    -- Create a dynamic entity for the Quasilumin that the player has to escort
    local quasilumin = npc:getZone():insertDynamicEntity({
        objtype = xi.objType.MOB,
        name = 'Quasilumin',
        groupId = 27,
        groupZoneId = 34,
        x = data.spawn.x,
        y = data.spawn.y,
        z = data.spawn.z,
        rotation = data.spawn.rotation,
        allegiance = xi.allegiance.PLAYER,
        isAggroable = true,
        specialSpawnAnimation = true,
        releaseIdOnDisappear = true,
    })

    if quasilumin == nil then
        return
    end

    npc:setLocalVar('QuasiluminId', quasilumin:getID())

    quasilumin:setSpawn(data.spawn.x, data.spawn.y, data.spawn.z, data.spawn.rotation)
    quasilumin:spawn()
    quasilumin:setStatus(xi.status.NORMAL)

    player:messageSpecial(ID.text.TIME_RESTRICTION, data.limit)
    quasilumin:setLocalVar('escort', npc:getID())
    quasilumin:setLocalVar('progress', 0)
    quasilumin:setLocalVar('expire', os.time() + utils.minutes(data.limit))
    quasilumin:showText(quasilumin, ID.text.REQUEST_CONFIRMED)
end

return entity
