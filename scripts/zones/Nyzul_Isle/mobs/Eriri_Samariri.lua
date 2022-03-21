-----------------------------------
--  MOB: Eiri Samasriri
-- Area: Nyzul Isle
-- Info: Enemy Leader, Spams Frog Song
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.enemyLeaderKill(mob)
        local instance = mob:getInstance()
        local chars = instance:getChars()
        for _, entity in ipairs(chars) do
            if player:hasStatusEffect(xi.effect.COSTUME) then
                player:delStatusEffect(xi.effect.COSTUME)
            end
        end
    end
end
