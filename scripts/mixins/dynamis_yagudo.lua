-- Dynamis Yagudo NM Mixin
-- Yagudo NMs in dynamis remove doom upon death
-- TODO: A benediction effect animation should play on doom removal

require("scripts/globals/mixins")
require("scripts/globals/status")

g_mixins = g_mixins or {}

g_mixins.dynamis_yagudo = function(mob)
    mob:addListener("DEATH", "DYNAMIS_YAGUDO_DOOM", function(mob, player)
        local players = mob:getZone():getPlayers()
        for name, player in pairs(players) do
            if mob:checkDistance(player) < 30 then
                player:delStatusEffectSilent(tpz.effect.DOOM)
            end
        end
    end)
end

return g_mixins.dynamis_yagudo
