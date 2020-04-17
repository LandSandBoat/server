-----------------------------------
-- Area: Apollyon NE
--  Mob: Hyperion
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()
        local battlefield = mob:getBattlefield()
        local randomF4 = battlefield:getLocalVar("randomF4")
        if randomF4 == mobID then
            tpz.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NE_PORTAL[4])
        end
    end
end