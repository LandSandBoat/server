-----------------------------------
-- Area: Apollyon SE
--  Mob: Evil Armory
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)
    mob:setMod(xi.mod.UDMGPHYS, -8000)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        GetNPCByID(ID.npc.APOLLYON_SE_CRATE[4]):setStatus(xi.status.NORMAL)
    end
end

return entity
