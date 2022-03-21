-----------------------------------
--  MOB: Vouivre
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/utils/nyzul")
require("scripts/globals/status")
-----------------------------------
entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGEN, 5)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 35)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.eliminateAllKill(mob)
    end
end
