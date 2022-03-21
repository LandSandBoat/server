-----------------------------------
--  MOB: Oriri Samariri
-- Area: Nyzul Isle
-- Info: Enemy Leader
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
        local instance = mob:getInstance()
        local chars = instance:getChars()
        for _, entity in ipairs(chars) do
            if player:hasStatusEffect(xi.effect.COSTUME) then
                player:delStatusEffect(xi.effect.COSTUME)
            end
        end
    end
end
