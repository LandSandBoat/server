-- Dynamis Yagudo NM Mixin
-- Yagudo NMs in dynamis remove doom upon death
-- TODO: A benediction effect animation should play on doom removal

require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/msg")

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.clear_doom = tpz.mix.clear_doom or {}

g_mixins = g_mixins or {}

tpz.mix.clear_doom.config = function(mob, params)
    if params.doomRemovalChance and type(params.doomRemovalChance) == "number" then
        mob:setLocalVar("[remove_doom]removalChance", params.doomRemovalChance)
    end
end

g_mixins.clear_doom = function(mob)
    mob:addListener("SPAWN", "REMOVE_DOOM_SPAWN", function(mob)
        mob:setLocalVar("[remove_doom]removalChance", 100)
    end)

    mob:addListener("DEATH", "REMOVE_DOOM", function(mob, player)
        if math.random(100) <= mob:getLocalVar("[remove_doom]removalChance") then
            local players = mob:getZone():getPlayers()
            for name, player in pairs(players) do
                if mob:checkDistance(player) < 30 then
                    if player:delStatusEffectSilent(tpz.effect.DOOM) then
                        player:messageBasic(tpz.msg.basic.NARROWLY_ESCAPE)
                    end
                end
            end
        end
    end)
end

return g_mixins.clear_doom
