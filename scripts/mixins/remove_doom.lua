-- Dynamis Yagudo NM Mixin
-- Yagudo NMs in dynamis remove doom upon death
-- TODO: A benediction effect animation should play on doom removal

require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/msg")

xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.clear_doom = xi.mix.clear_doom or {}

g_mixins = g_mixins or {}

xi.mix.clear_doom.config = function(mob, params)
    if params.doomRemovalChance and type(params.doomRemovalChance) == "number" then
        mob:setLocalVar("[remove_doom]removalChance", params.doomRemovalChance)
    end
end

g_mixins.clear_doom = function(doomMob)
    doomMob:addListener("SPAWN", "REMOVE_DOOM_SPAWN", function(mob)
        mob:setLocalVar("[remove_doom]removalChance", 100)
    end)

    doomMob:addListener("DEATH", "REMOVE_DOOM", function(mob, player)
        if math.random(1, 100) <= mob:getLocalVar("[remove_doom]removalChance") then
            local players = mob:getZone():getPlayers()

            for name, playerVal in pairs(players) do
                if mob:checkDistance(player) < 30 then
                    if playerVal:delStatusEffectSilent(xi.effect.DOOM) then
                        playerVal:messagePublic(xi.msg.basic.NARROWLY_ESCAPE, playerVal)
                    end
                end
            end
        end
    end)
end

return g_mixins.clear_doom
