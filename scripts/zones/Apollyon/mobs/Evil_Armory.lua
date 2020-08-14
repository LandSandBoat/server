-----------------------------------
-- Area: Apollyon SE
--  Mob: Evil Armory
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)
    mob:setMod(tpz.mod.UDMGPHYS, -80)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        GetNPCByID(ID.npc.APOLLYON_SE_CRATE[4]):setStatus(tpz.status.NORMAL)
    end
end
