-----------------------------------
-- Area: Apollyon SE
--  Mob: Evil Armory
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)
    mob:setMod(tpz.mod.UDMGPHYS, -80)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        GetNPCByID(ID.npc.APOLLYON_SE_CRATE[4]):setStatus(tpz.status.NORMAL)
    end
end

return entity
