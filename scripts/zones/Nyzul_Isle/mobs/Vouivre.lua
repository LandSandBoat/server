-----------------------------------
--  MOB: Vouivre
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/utils/nyzul")
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMod(xi.mod.REGEN, 5)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 35)
    mob:addImmunity(xi.immunity.TERROR)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.eliminateAllKill(mob)
    end
end
