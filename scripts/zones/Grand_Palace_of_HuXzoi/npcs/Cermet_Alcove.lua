-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Cermet Alcove
-- Note: Escort Quest
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------

local escorts =
{
    [16916927] =
    {
        ['limit'] = 5,
        ['spawn'] = { -260.000, -1.000,  423.000, 190 },
    },
    [16916928] =
    {
        ['limit'] = 30,
        ['spawn'] = {  797.000, -1.000,  460.000, 125 },
    },
    [16916929] =
    {
        ['limit'] = 30,
        ['spawn'] = {  540.000, -1.000,  297.000, 60 },
    },
    [16916930] =
    {
        ['limit'] = 40,
        ['spawn'] = { -540.000, -1.000,  297.000, 60 },
    },
}

local this = {}

this.onTrigger = function(player, npc)
    local data = escorts[npc:getID()]
    if data == nil then
        return
    end

    local lastId = npc:getLocalVar("QuasiluminId")
    if lastId ~= 0 and GetMobByID(lastId) ~= nil then
        -- Last one for this alcove is still alive
        player:messageSpecial(ID.text.RECENTLY_ACTIVATED)
        return
    end

    local quasilumin = npc:getZone():insertExtra(26009, 34)
    if quasilumin == nil then
        return
    end
    npc:setLocalVar("QuasiluminId", quasilumin:getID())

    quasilumin:setSpawn(data.spawn)
    quasilumin:spawn()

    player:messageSpecial(ID.text.TIME_RESTRICTION, data.limit)
    quasilumin:setLocalVar("escort", npc:getID())
    quasilumin:setLocalVar("progress", 0)
    quasilumin:setLocalVar("expire", os.time() + data.limit * 60)
    quasilumin:showText(quasilumin, ID.text.REQUEST_CONFIRMED)
end

this.onEventUpdate = function(player, csid, option)
end

this.onEventFinish = function(player, csid, option)
end

return this
