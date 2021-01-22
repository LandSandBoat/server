-----------------------------------
-- Area: Apollyon NE
--  Mob: Cronos
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(tpz.mod.UDMGPHYS, -100)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()
        local battlefield = mob:getBattlefield()
        local randomF4 = battlefield:getLocalVar("randomF4")
        if randomF4 == mobID then
            tpz.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NE_PORTAL[4])
        end
    end
end

return entity
